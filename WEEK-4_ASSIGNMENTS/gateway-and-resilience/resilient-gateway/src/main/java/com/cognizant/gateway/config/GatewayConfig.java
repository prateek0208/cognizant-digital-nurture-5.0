package com.cognizant.gateway.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfig {

    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()
                .route("account-service", r -> r
                        .path("/accounts/**")
                        .filters(f -> f
                                .circuitBreaker(config -> config
                                        .setName("accountCircuitBreaker")
                                        .setFallbackUri("forward:/fallback"))
                        )
                        .uri("lb://account-service"))
                .route("loan-service", r -> r
                        .path("/loans/**")
                        .filters(f -> f
                                .circuitBreaker(config -> config
                                        .setName("loanCircuitBreaker")
                                        .setFallbackUri("forward:/fallback"))
                        )
                        .uri("lb://loan-service"))
                .route("greet-service", r -> r
                        .path("/greet/**")
                        .filters(f -> f
                                .circuitBreaker(config -> config
                                        .setName("greetCircuitBreaker")
                                        .setFallbackUri("forward:/fallback"))
                        )
                        .uri("lb://greet-service"))
                .build();
    }
}
