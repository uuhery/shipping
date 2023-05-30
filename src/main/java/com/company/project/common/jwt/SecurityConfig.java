package com.company.project.common.jwt;

import com.company.project.common.aop.aspect.RateLimitAspect;
import com.company.project.common.config.FileUploadProperties;
import com.company.project.service.sys.MyUserDetailsService;
import com.company.project.service.sys.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.HttpStatusReturningLogoutSuccessHandler;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: zlf
 * @Date: 2021/03/30/20:45
 * @Description:
 */
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Resource
    private FileUploadProperties fileUploadProperties;

    @Autowired
    private MyUserDetailsService userDetailsService;

    @Autowired
    private RestfulAccessDeniedHandler restfulAccessDeniedHandler;
    @Autowired
    private RestAuthenticationEntryPoint restAuthenticationEntryPoint;

    @Autowired
    private JwtAuthenticationTokenFilter jwtAuthenticationTokenFilter;

    @Autowired
    private RateLimitAspect rateLimitAspect;

    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity.csrf()// 由于使用的是JWT，我们这里不需要csrf
                .disable()
                .sessionManagement()// 基于token，所以不需要session
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .enableSessionUrlRewriting(true)
                .and()
                .authorizeRequests()
                .antMatchers("/sys/user/login", "/sys/user/token", "/sys/getVerify", "/sys/checkVerify", "/index/login", "/index/register")// 对登录注册要允许匿名访问
                .permitAll()
                .antMatchers(HttpMethod.GET, // 允许对于网站静态资源的无授权访问
                    "/index/**",
                    "*.html",
                    "/static/**",
                    "/doc.html",
                    "/swagger-resources/**",
                    "/v2/api-docs",
                    "/v2/api-docs-ext",
                    "/webjars/**",
                    "/druid/**",
                    "/favicon.ico",
                    "/captcha.jpg",
                    "/csrf",
                    fileUploadProperties.getAccessUrl(),
                    "/images/**",
                    "/js/**",
                    "/layui/**",
                    "/css/**",
                    "/layui-ext/**",
                    "/app/api/**",
                    "/**"
                    )
                .permitAll()
                .antMatchers(HttpMethod.OPTIONS)//跨域请求会先进行一次options请求
                .permitAll()
                .anyRequest()// 除上面外的所有请求全部需要鉴权认证
                .authenticated()
                .and()
                .formLogin()
                .loginPage("/index/login")// 登录页面
                .loginProcessingUrl("/sys/user/login") // 登录表单提交地址
                .and()
                .logout() // 添加登出配置
                .logoutUrl("/sys/user/logout") // 配置登出接口地址
                .logoutSuccessHandler(new HttpStatusReturningLogoutSuccessHandler(HttpStatus.OK)) // 配置登出成功后的处理器
                .deleteCookies("JSESSIONID");// 删除Cookie
//                .antMatchers("/**")//测试时全部运行访问
//                .permitAll()
        // 禁用缓存
        httpSecurity.headers().cacheControl();
        // 添加filter
        httpSecurity.addFilterBefore(jwtAuthenticationTokenFilter, UsernamePasswordAuthenticationFilter.class);
        //添加自定义未授权和未登录结果返回
        httpSecurity.exceptionHandling()
                .accessDeniedHandler(restfulAccessDeniedHandler)
                .authenticationEntryPoint(restAuthenticationEntryPoint);
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService)
                .passwordEncoder(new BCryptPasswordEncoder());
    }

//    @Bean
//    public PasswordEncoder passwordEncoder() {
//        return new BCryptPasswordEncoder();
//    }



//    @Bean
//    public JwtAuthenticationTokenFilter jwtAuthenticationTokenFilter(){
//        return new JwtAuthenticationTokenFilter();
//    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}
