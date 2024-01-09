# Notes

- Assumes a mysql database
- Uses aws cli but any s3-compatible storage backend will work
- Like in task 2, I would not implement periodic restoration in the script itself. I would use an external scheduling tool like cron to actually run the restoration script
- Could be further improved by ensuring db does not have any active transactions and preventing new transactions prior to the restoration
