# Этап сборки приложения
FROM golang:1.26-alpine AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем go.mod и go.sum для загрузки зависимостей
COPY go.mod go.sum ./
RUN go mod download

# Копируем все исходные файлы
COPY . .

# Собираем бинарный файл
RUN go build -o /app/11sprint .

# Этап финального минимального образа
FROM alpine:latest

# Устанавливаем рабочую директорию
WORKDIR /root/

# Копируем бинарный файл из этапа сборки
COPY --from=builder /app/11sprint ./

# Копируем файл базы данных (tracker.db)
COPY tracker.db ./

# Запускаем приложение
CMD ["./11sprint"]