package com.company.project.utilities;

import com.netflix.hystrix.HystrixCommand;
import com.netflix.hystrix.HystrixCommandGroupKey;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Component
public class HystrixFilterFactory extends AbstractGatewayFilterFactory<HystrixFilterFactory.Config> {

    public HystrixFilterFactory() {
        super(Config.class);
    }

    @Override
    public GatewayFilter apply(Config config) {
        return (exchange, chain) -> {
            // 添加Hystrix过滤器逻辑
            return Mono.fromCallable(() -> {
                return new HystrixCommand<String>(HystrixCommandGroupKey.Factory.asKey("Group")) {
                    @Override
                    protected String run() throws Exception {
                        return "Fallback response";
                    }

                    @Override
                    protected String getFallback() {
                        return "Fallback response";
                    }
                }.execute();
            }).flatMap(response -> {
                // 处理降级后的结果
                return chain.filter(exchange);
            }).onErrorResume(throwable -> {
                // 发生异常时的降级逻辑
                return Mono.error(new RuntimeException("Fallback response"));
            });
        };
    }

    public static class Config {
        private String fallbackMessage = "Fallback response";

        public String getFallbackMessage() {
            return fallbackMessage;
        }

        public void setFallbackMessage(String fallbackMessage) {
            this.fallbackMessage = fallbackMessage;
        }
    }
}
