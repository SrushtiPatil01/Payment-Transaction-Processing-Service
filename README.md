# Payment-Transaction-Processing-Service

## Project Summary

A secure, high-performance payment transaction processing service built with Java, Spring, Kafka, and AWS. Designed to handle payment operations reliably while ensuring transactional consistency and asynchronous settlement workflows.

## Overview

- Built with Java & Spring MVC for creating secure and maintainable REST APIs
- Spring Security for authentication and authorization
- Spring Data JPA for database interaction with PostgreSQL
- Idempotency & Optimistic Locking to prevent duplicate transactions and maintain consistency
- Kafka Integration for asynchronous settlement and notification workflows
- AWS RDS with range partitioning to optimize transaction query performance
- Containerized with Docker and deployed on AWS ECS for scalable, cloud-native deployment


## Tech Stack

- **Java** 
- **Spring MVC & Spring Security** 
- **Spring Data JPA** 
- **PostgreSQL (AWS RDS)**
- **Kafka**
- **Docker** 
- **AWS ECS** 

## Performance

- Optimized transaction query performance, reducing average query time by 70%
- Reliable, secure handling of high-volume payment transactions
- Asynchronous processing ensures low-latency user responses
