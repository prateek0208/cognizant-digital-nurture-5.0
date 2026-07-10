package com.library.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

/**
 * Exercise 3: Logging Aspect that tracks method execution times.
 * Uses @Around advice to measure and log the time taken by each method
 * in the com.library package.
 */
@Aspect
public class LoggingAspect {

    /**
     * Around advice that logs the execution time of every method
     * in the com.library.service and com.library.repository packages.
     */
    @Around("execution(* com.library.service.*.*(..)) || execution(* com.library.repository.*.*(..))")
    public Object logExecutionTime(ProceedingJoinPoint joinPoint) throws Throwable {
        String methodName = joinPoint.getSignature().toShortString();
        long startTime = System.currentTimeMillis();

        System.out.println("[LoggingAspect] Starting: " + methodName);

        Object result = joinPoint.proceed();

        long endTime = System.currentTimeMillis();
        long executionTime = endTime - startTime;

        System.out.println("[LoggingAspect] Completed: " + methodName
                + " | Execution time: " + executionTime + " ms");

        return result;
    }
}
