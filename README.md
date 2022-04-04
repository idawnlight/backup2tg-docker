# Backup to Telegram in Docker

## Environment

| Environment | Description |
| --- | ----------- |
| BACKUP_DIR | Directories to backup, split with `;` |
| BACKUP_DB | Databases to backup, split with `;` (with `mysqldump`) |
| BACKUP_POSTGRES_DB | PostgreSQL Databases to backup, split with `;` (with `pg_dump`) |
| BOT_TOKEN | Telegram bot token |
| BOT_API | Custom bot api for larger files, default `https://api.telegram.org` (without slash) |
| CHAT_ID | Telegram chat id |
| MYSQL_USERNAME | MySQL username |
| MYSQL_PASSWORD | MySQL password |
| MYSQL_PORT | MySQL port |
| MYSQL_HOST | MySQL host |
| POSTGRES_CONNECTION_URI | PostgreSQL Connection URI, like `postgresql://user:secret@localhost`, without `dbname` |