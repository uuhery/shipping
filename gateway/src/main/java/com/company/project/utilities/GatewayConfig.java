package com.company.project.utilities;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfig {

    @Bean
    public HystrixFilterFactory hystrixFilterFactory() {
        return new HystrixFilterFactory();
    }

    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder, HystrixFilterFactory hystrixFilterFactory) {
        return builder.routes()
                .route("external-management", r -> r.path("/external/**")
                        .filters(f -> f.stripPrefix(1).filter(hystrixFilterFactory.apply(new HystrixFilterFactory.Config())))
                        .uri("lb://external-management"))
                .route("shipping-management", r -> r.path("/shipping/**")
                        .filters(f -> f.stripPrefix(1).filter(hystrixFilterFactory.apply(new HystrixFilterFactory.Config())))
                        .uri("lb://shipping-management"))
                .build();
    }
}