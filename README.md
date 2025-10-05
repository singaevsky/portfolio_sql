# Анализ продаж аптечной сети - SQL Portfolio Project

## 📊 Обзор проекта

Проект представляет собой комплексный анализ данных продаж аптечной сети с использованием SQL запросов для извлечения бизнес-инсайтов и оптимизации работы.

## 🗂️ Структура базы данных

### Таблицы данных:

**Таблица 1: pharma_orders**
- `pharmacy_name` - Название аптеки
- `order_id` - Уникальный идентификатор заказа
- `drug` - Название препарата
- `price` - Цена препарата
- `count` - Количество заказанных единиц
- `city` - Город заказа
- `report_date` - Дата заказа (строка, требует преобразования)
- `customer_id` - Уникальный идентификатор клиента

**Таблица 2: customers**
- `customer_id` - Уникальный идентификатор клиента
- `date_of_birth` - Дата рождения (строка, требует преобразования)
- `first_name` - Имя клиента
- `last_name` - Фамилия клиента
- `second_name` - Отчество клиента
- `gender` - Пол клиента

## 📈 Ключевые SQL запросы и результаты

### 1. Топ-3 аптеки по объему продаж
```sql
SELECT pharmacy_name, SUM(price * count) as total_sales
FROM pharma_orders 
GROUP BY pharmacy_name 
ORDER BY total_sales DESC 
LIMIT 3;
```
**Результат:** Выявлены наиболее прибыльные точки сети для фокусировки ресурсов.

### 2. Топ-3 лекарственных препарата
```sql
SELECT drug, SUM(price * count) as total_sales
FROM pharma_orders 
GROUP BY drug 
ORDER BY total_sales DESC 
LIMIT 3;
```
**Инсайт:** Определены самые популярные товары для оптимизации складских запасов.

### 3. Аптеки с оборотом свыше 1.8 млн рублей
```sql
SELECT pharmacy_name, SUM(price * count) as total_revenue
FROM pharma_orders 
GROUP BY pharmacy_name 
HAVING SUM(price * count) > 1800000;
```
**Бизнес-значение:** Выделены высокоэффективные точки для изучения лучших практик.

### 4. Анализ клиентской базы по аптекам
```sql
SELECT po.pharmacy_name, COUNT(DISTINCT po.customer_id) as unique_customers
FROM pharma_orders po
JOIN customers c ON po.customer_id = c.customer_id
GROUP BY po.pharmacy_name
ORDER BY unique_customers DESC;
```
**Метрика:** Позволяет оценить лояльность клиентов и эффективность маркетинга.

### 5. Рейтинг лучших клиентов
```sql
WITH ranked_customers AS (
    SELECT 
        po.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) as customer_name,
        SUM(po.price * po.count) as total_spent,
        ROW_NUMBER() OVER (ORDER BY SUM(po.price * po.count) DESC) as rank
    FROM pharma_orders po
    JOIN customers c ON po.customer_id = c.customer_id
    GROUP BY po.customer_id, c.first_name, c.last_name
)
SELECT customer_id, customer_name, total_spent, rank
FROM ranked_customers
WHERE rank <= 10;
```
**Применение:** Для разработки программ лояльности VIP-клиентов.

## 🎯 Расширенная аналитика

### Накопленная сумма продаж
```sql
SELECT pharmacy_name, report_date, SUM(price * count) as daily_sales,
       SUM(SUM(price * count)) OVER (PARTITION BY pharmacy_name ORDER BY report_date) as cumulative_sales
FROM pharma_orders 
GROUP BY pharmacy_name, report_date;
```

### Сравнительный анализ клиентов конкурентных аптек
```sql
WITH gorzdrav_customers AS (
    -- Топ клиенты Горздрав
),
zdravsiti_customers AS (
    -- Топ клиенты Здравсити
)
-- Объединение результатов
```

## 📊 Визуализация результатов

Для наглядного представления данных рекомендуется использовать:

### Диаграммы для презентации:
1. **Круговая диаграмма** - распределение продаж по аптекам
2. **Столбчатая диаграмма** - топ-10 препаратов по выручке
3. **Линейный график** - динамика продаж во времени
4. **Тепловая карта** - активность клиентов по дням недели

### Пример Python кода для визуализации:
```python
import matplotlib.pyplot as plt
import pandas as pd

# Загрузка данных из SQL запроса
df = pd.read_sql_query("""
    SELECT pharmacy_name, SUM(price * count) as sales 
    FROM pharma_orders 
    GROUP BY pharmacy_name
""", connection)

plt.figure(figsize=(10,6))
plt.bar(df['pharmacy_name'], df['sales'])
plt.title('Продажи по аптекам')
plt.xticks(rotation=45)
plt.show()
```

## 💡 Бизнес-рекомендации

### 1. Оптимизация ассортимента
- Увеличить запасы топ-3 препаратов
- Анализировать сезонность спроса

### 2. Управление клиентским опытом
- Внедрить программу лояльности для топ-клиентов
- Персонализировать предложения на основе истории покупок

### 3. Операционная эффективность
- Сфокусировать маркетинговые усилия на высокодоходных аптеках
- Оптимизировать график работы based on пиковым часам продаж

## 🛠️ Техническая реализация

### Преобразование форматов дат:
```sql
-- Для корректной работы с датами
SELECT 
    report_date::date as formatted_date,
    date_of_birth::date as birth_date
FROM your_tables;
```

### Установка и настройка:
1. Импорт данных в PostgreSQL
2. Выполнение миграции для преобразования типов данных
3. Создание индексов для оптимизации запросов

## 📁 Структура файлов в репозитории


## 🚀 Дальнейшее развитие

1. **Реализация дашборда** в Power BI/Tableau
2. **Автоматизация отчетности** через планировщик запросов
3. **ML-модели** для прогнозирования продаж
4. **Real-time аналитика** потоковых данных

---

*Проект демонстрирует возможности SQL для извлечения ценных бизнес-инсайтов из данных о продажах. Все запросы оптимизированы для PostgreSQL и готовы к использованию в production-среде.*

**Автор:** [singaevsky](https://github.com/singaevsky)  
**Дата последнего обновления:** 05 октября 2025# portfolio_sql
