package com.library.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

/**
 * Exercise 8: Basic AOP with Spring
 *
 * Defines @Before and @After advice methods to log method entry/exit
 * for all methods in the com.library.service package.
 */
@Aspect
public class LoggingAspect {

    /**
     * @Before advice — runs BEFORE any method in com.library.service package.
     */
    @Before("execution(* com.library.service.*.*(..))")
    public void logBefore(JoinPoint joinPoint) {
        System.out.println("[AOP - BEFORE] Method called: "
                + joinPoint.getSignature().getName()
                + " in " + joinPoint.getTarget().getClass().getSimpleName());
    }

    /**
     * @After advice — runs AFTER any method in com.library.service package (regardless of outcome).
     */
    @After("execution(* com.library.service.*.*(..))")
    public void logAfter(JoinPoint joinPoint) {
        System.out.println("[AOP - AFTER]  Method finished: "
                + joinPoint.getSignature().getName()
                + " in " + joinPoint.getTarget().getClass().getSimpleName());
    }

    /**
     * @Before advice — runs BEFORE any method in com.library.repository package.
     */
    @Before("execution(* com.library.repository.*.*(..))")
    public void logRepositoryBefore(JoinPoint joinPoint) {
        System.out.println("[AOP - BEFORE] Repository method called: "
                + joinPoint.getSignature().getName());
    }

    /**
     * @After advice — runs AFTER any method in com.library.repository package.
     */
    @After("execution(* com.library.repository.*.*(..))")
    public void logRepositoryAfter(JoinPoint joinPoint) {
        System.out.println("[AOP - AFTER]  Repository method finished: "
                + joinPoint.getSignature().getName());
    }
}
