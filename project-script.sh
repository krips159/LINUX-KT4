#!/bin/bash

# Название проекта
PROJECT_NAME=$1

# Если имя не передали аргументом
if [ -z "$PROJECT_NAME" ]; then
    echo "Имя проекта не указано."
    read -p "Введите имя проекта: " PROJECT_NAME
fi

# Функция создания файла
create_file() {
    touch "$1"
    echo "Создан файл: $1"
}

# Создаём папку для отчётов
mkdir -p reports

# Создаём папку проекта
mkdir -p "$PROJECT_NAME"

echo "Создание проекта: $PROJECT_NAME"
echo "--------------------------------"

# Создаём файлы проекта
FILES=("README.txt" "main.txt" "config.txt")

for FILE in "${FILES[@]}"; do
    create_file "$PROJECT_NAME/$FILE"
done

# Записываем информацию в README
echo "Проект: $PROJECT_NAME" > "$PROJECT_NAME/README.txt"
echo "Создан с помощью Bash-скрипта." >> "$PROJECT_NAME/README.txt"

# Записываем конфигурацию
echo "project_name=$PROJECT_NAME" > "$PROJECT_NAME/config.txt"

# Записываем содержимое main.txt
echo "Основной файл проекта." > "$PROJECT_NAME/main.txt"

echo ""
echo "Проверка результата:"
echo "--------------------------------"

# Проверяем существование папки
if [ -d "$PROJECT_NAME" ]; then
    echo "Папка проекта существует: OK"
else
    echo "Ошибка: папка проекта не создана."
fi

# Выводим список файлов
echo ""
echo "Файлы проекта:"
ls -l "$PROJECT_NAME"

# Количество файлов
FILE_COUNT=$(find "$PROJECT_NAME" -type f | wc -l)

echo ""
echo "Количество файлов: $FILE_COUNT"

# Создаём отчёт
REPORT="reports/report.txt"

echo "Отчёт о создании проекта" > "$REPORT"
echo "=========================" >> "$REPORT"
echo "Дата: $(date)" >> "$REPORT"
echo "Название проекта: $PROJECT_NAME" >> "$REPORT"
echo "Количество файлов: $FILE_COUNT" >> "$REPORT"
echo "" >> "$REPORT"
echo "Содержимое проекта:" >> "$REPORT"
find "$PROJECT_NAME" -type f >> "$REPORT"

echo ""
echo "Отчёт сохранён в: $REPORT"
echo ""
echo "Работа скрипта завершена."
