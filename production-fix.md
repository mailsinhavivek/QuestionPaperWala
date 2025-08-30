# Production Database Fix Guide

## 1. Check User Subscription Status

Use this endpoint to check if a user's subscription is properly recorded:

```bash
curl -X POST https://questionpaper.replit.app/api/admin/check-user \
  -H "Content-Type: application/json" \
  -d '{"email": "anjaneya1402@gmail.com"}'
```

## 2. Fix Missing Subscription

If payment was successful but subscription wasn't recorded, use:

```bash
curl -X POST https://questionpaper.replit.app/api/admin/fix-subscription \
  -H "Content-Type: application/json" \
  -d '{
    "email": "anjaneya1402@gmail.com",
    "planType": "monthly",
    "paymentId": "ACTUAL_PAYMENT_ID_FROM_GATEWAY",
    "country": "India",
    "curriculum": "CBSE",
    "userClass": "10"
  }'
```

## 3. Production Webhook Debugging

### Check Webhook URLs in Payment Gateway Dashboards:

**Cashfree:**
- Webhook URL: `https://questionpaper.replit.app/api/cashfree-webhook`

**Razorpay:**
- Webhook URL: `https://questionpaper.replit.app/api/razorpay-webhook`

### Manual Verification Endpoints:

**For Cashfree:**
```bash
curl -X POST https://questionpaper.replit.app/api/cashfree/manual-verify \
  -H "Content-Type: application/json" \
  -d '{
    "orderId": "CASHFREE_ORDER_ID",
    "userId": "USER_ID",
    "planType": "monthly",
    "country": "India",
    "curriculum": "CBSE",
    "userClass": "10"
  }'
```

## 4. Common Issues and Solutions

### Issue: Webhooks not being called
- **Solution:** Verify webhook URLs in payment gateway dashboards
- **Check:** Ensure production domain is whitelisted

### Issue: Environment variables missing
- **Solution:** Verify all secrets are properly set in production
- **Required:** CASHFREE_APP_ID, CASHFREE_SECRET_KEY, RAZORPAY_KEY_ID, RAZORPAY_KEY_SECRET

### Issue: Database connection problems
- **Solution:** Check DATABASE_URL in production environment
- **Test:** Use the admin endpoints to verify database connectivity

## 5. For Anjaneya's Specific Case

1. First check current status:
```bash
curl -X POST https://questionpaper.replit.app/api/admin/check-user \
  -H "Content-Type: application/json" \
  -d '{"email": "anjaneya1402@gmail.com"}'
```

2. If subscription is missing, fix it with his actual payment details:
```bash
curl -X POST https://questionpaper.replit.app/api/admin/fix-subscription \
  -H "Content-Type: application/json" \
  -d '{
    "email": "anjaneya1402@gmail.com",
    "planType": "monthly",
    "paymentId": "HIS_ACTUAL_PAYMENT_ID",
    "country": "India",
    "curriculum": "CBSE",
    "userClass": "10"
  }'
```

Replace `HIS_ACTUAL_PAYMENT_ID` with the actual payment ID from Razorpay/Cashfree dashboard.