# Practice Papers - Production Deployment Guide

## 🚀 Fresh Production Deployment Setup

This guide provides step-by-step instructions for deploying Practice Papers from development to production.

## 📋 Pre-Deployment Checklist

### Required Environment Variables
Set these in your production environment before deployment:

```bash
# Database (Auto-configured in Replit)
DATABASE_URL=your_neon_database_url

# OpenAI Integration (Required)
OPENAI_API_KEY=your_openai_api_key

# Payment Gateways (Required for subscriptions)
RAZORPAY_KEY_ID=your_razorpay_key_id
RAZORPAY_KEY_SECRET=your_razorpay_secret
CASHFREE_APP_ID=your_cashfree_app_id
CASHFREE_SECRET_KEY=your_cashfree_secret

# Email Service (Required for notifications)
SENDGRID_API_KEY=your_sendgrid_api_key

# Session Security (Auto-generated if not provided)
SESSION_SECRET=your_secure_session_secret

# Environment
NODE_ENV=production
```

### Deployment Steps

1. **Clone/Upload Code**
   - Ensure all files from this repository are in production
   - Verify package.json and dependencies are intact

2. **Install Dependencies**
   ```bash
   npm install
   ```

3. **Database Setup**
   ```bash
   # Push schema to production database
   npm run db:push --force
   ```

4. **Build Application**
   ```bash
   npm run build
   ```

5. **Start Production Server**
   ```bash
   npm start
   ```

## 🔧 Production Configuration

### Payment Gateway Webhooks
Configure these webhook URLs in your payment dashboards:

**Razorpay:**
- Webhook URL: `https://your-domain.replit.app/api/razorpay-webhook`
- Events: payment.captured, payment.failed, subscription.charged

**Cashfree:**
- Webhook URL: `https://your-domain.replit.app/api/cashfree-webhook`
- Events: PAYMENT_SUCCESS, PAYMENT_FAILED, ORDER_PAID

### Security Headers
The application is configured with:
- CORS for payment gateway domains
- Secure session cookies for HTTPS
- CSRF protection via SameSite cookies

## 📁 Critical Files for Production

### Core Application Files
- `package.json` - Dependencies and scripts
- `server/index.ts` - Main server with production CORS
- `server/routes.ts` - API routes with session management
- `server/db.ts` - Database connection
- `shared/schema.ts` - Database schema

### Configuration Files
- `drizzle.config.ts` - Database migration config
- `vite.config.ts` - Build configuration
- `tsconfig.json` - TypeScript settings
- `tailwind.config.ts` - CSS framework config

### Frontend Assets
- `client/` directory - Complete React application
- `dist/` directory - Built production assets (created during build)

## 🔍 Health Checks

### Database Connection
```bash
# Test database connectivity
npm run db:push
```

### API Endpoints
Test these endpoints after deployment:
- `GET /api/countries` - Should return country list
- `POST /api/signup` - User registration
- `POST /api/login` - User authentication
- `GET /api/curricula` - Curriculum data

### Payment Integration
- Test Razorpay checkout flow
- Verify Cashfree payment processing
- Confirm webhook delivery

## 🚨 Troubleshooting

### Common Issues

1. **Database Connection Errors**
   - Verify DATABASE_URL is set correctly
   - Check if database is provisioned
   - Run `npm run db:push --force` to recreate schema

2. **CORS Errors**
   - Ensure production domain is whitelisted
   - Check that x-user-id header is allowed

3. **Payment Failures**
   - Verify API keys are production keys (not test)
   - Check webhook URLs are correctly configured
   - Ensure HTTPS is enabled for webhooks

4. **Session Issues**
   - Check SESSION_SECRET is set
   - Verify database sessions table exists
   - Confirm secure cookies are enabled

## 🔒 Security Considerations

- All API keys should be production values
- SESSION_SECRET must be unique and secure
- Database should have proper access controls
- HTTPS must be enabled for payment processing
- Regular security updates for dependencies

## 📊 Monitoring

Monitor these metrics in production:
- Database connection pool status
- API response times
- Payment success/failure rates
- User authentication success
- Error logs and exceptions

## 🆘 Emergency Rollback

If issues occur:
1. Check application logs for errors
2. Verify environment variables
3. Test database connectivity
4. Rollback to previous stable version if needed

---

**Deployment Date:** $(date)
**Version:** 1.0.0
**Environment:** Production