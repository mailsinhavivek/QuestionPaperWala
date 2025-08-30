# Overview

Practice Papers is a curriculum-based question paper generator designed specifically for the Indian education system. The application allows educators to create standardized question papers that comply with various Indian curricula including CBSE, ICSE, state boards, and international programs like IB and IGCSE. The system uses intelligent question generation to create comprehensive question papers with proper weightage distribution, difficulty levels, and curriculum alignment.

# User Preferences

Preferred communication style: Simple, everyday language.

# System Architecture

## Frontend Architecture

The frontend is built as a React Single Page Application (SPA) using:

- **React 18** with TypeScript for type safety and modern component patterns
- **Vite** as the build tool providing fast development server and optimized production builds
- **Wouter** for lightweight client-side routing instead of React Router
- **TanStack Query** for server state management, caching, and data fetching
- **Tailwind CSS** with custom CSS variables for styling and responsive design
- **Shadcn/ui** component library built on Radix UI primitives for consistent, accessible UI components

### Component Structure
- Multi-step form wizard for question paper generation with progress tracking
- Reusable UI components following atomic design principles
- Form validation using React Hook Form with Zod schemas
- Toast notifications for user feedback

## Backend Architecture

The backend follows a traditional REST API pattern using:

- **Express.js** server with TypeScript for API endpoints
- **Drizzle ORM** for database operations and schema management
- **PostgreSQL** as the primary database (configured for Neon serverless)
- **OpenAI GPT-4o** integration for intelligent question generation
- **Connect-pg-simple** for session management

### API Design
- RESTful endpoints for curriculum data, question generation, and question paper management
- Structured error handling with proper HTTP status codes
- Request validation using Zod schemas shared between client and server
- Comprehensive logging for API requests and responses

## Data Storage Solutions

### Database Schema
- **question_papers** table storing generated question papers with metadata and JSON content
- **curriculum_data** table containing comprehensive curriculum information including chapters, topics, and syllabus data
- Uses PostgreSQL JSONB for flexible storage of nested curriculum and question data

### In-Memory Storage
- Development fallback using MemStorage class with comprehensive Indian curriculum data
- Supports CBSE, ICSE, various state boards with proper subject and chapter mappings
- Includes weightage information and difficulty distributions

## Authentication and Authorization

Currently implements basic session-based authentication infrastructure without user-specific features. The system is designed to be extended with proper user management, role-based access control, and question paper history tracking.

## Question Generation System

### Intelligent Technology Integration
- Uses OpenAI GPT-4o model for intelligent question generation
- Curriculum-aware prompts that understand Indian education standards
- Supports multiple question types: MCQ, Short Answer, Long Answer, and Case Study questions
- Maintains curriculum compliance and proper difficulty distribution

### Content Structure
- Hierarchical curriculum organization: Curriculum → State → Class → Subject → Chapters → Topics
- Flexible topic selection allowing granular control over question paper scope
- Configurable question type distribution and marking schemes
- Multi-language support for regional requirements

# External Dependencies

## Third-Party Services
- **OpenAI API** for intelligent question generation using GPT-4o model
- **Neon Database** as PostgreSQL hosting service for production deployments
- **Replit** development environment with custom Vite plugins for enhanced development experience

## Key Libraries
- **Drizzle ORM** with PostgreSQL dialect for database operations and migrations
- **TanStack Query** for efficient data fetching, caching, and synchronization
- **Radix UI** primitives providing accessible, unstyled UI components
- **Zod** for runtime type validation and schema definition
- **Date-fns** for date manipulation and formatting
- **Class Variance Authority** for component variant management
- **Tailwind CSS** for utility-first styling with custom design system

## Development Tools
- **Vite** with React plugin for fast development and optimized builds
- **TypeScript** for static type checking and improved developer experience
- **ESBuild** for server-side bundling and production builds
- **PostCSS** with Tailwind CSS for style processing