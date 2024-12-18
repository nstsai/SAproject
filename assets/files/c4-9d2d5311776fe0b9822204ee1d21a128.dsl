workspace {

    model {
        user = person "Пользователь" "Пользователь платформы (учитель/ученик)" 
        educationSystem = softwareSystem "Образовательная система" "Платформа для связи репетиторов и учеников" {
            webApp = container "Web-приложение" "Интерфейс для клиентов." "React (SPA)" {
                    tags "UI"
                localStorage = component "Local Storage" "Хранит данные на клиенте" {
                    tags "Storage"
                    }
                browser = component "Web-browser" {
                    tags "browser"
                }
            }
            backend = container "Backend" "Обрабатывает бизнес-логику, содержит сервисы и базы данных." "C#/.NET" {
                api = component "API Gateway" "Распределяет запросы в нужные модули" "Business Logic" {
                    tags "api"
                }
                Auth = component "Authorisation Module" "Регистрация/авторизация пользователей. Генерирует/обновляет JWT-токен" 
                Profile = component "Profile Module" "Личный кабинет пользователя"
                Subscription = component "Subscription Module" "Управление подпиской" 
                Support = component "Support Module" "Служба поддержки" 
                dbComponent = component "Database Component" "Обеспечивает управление данными"
                logComponent = component "Logging Component" "Обеспечивает взаимодействие с системой логирования"
                monComponent = component "Monitoring Component" "Обеспечивает взаимодействие с системой мониторинга"
            }
            DB = container "Database" "Хранит данные" "PostgreSQL" {
                tags "Database"
            }
            cache = container "Cache" "База данных для кеширования" "Redis" {
                tags "Cache"
            }
        }
        
        logging = softwareSystem "Система Логирования" "Система для сбора и анализа логов" "ELK" {
            tags "log"
        }
        monitoring = softwareSystem "Система мониторинга" "Система для мониторинга и алертов" "Prometheus + Grafana" {
            tags "monitoring"
        }

        paymentSystem = softwareSystem "Payment System" "Платежная система"
        mailSystem = softwareSystem "Mindbox" "Платформа автоматизации рассылок"
        documentSystem = softwareSystem "Document System" "Система для проверки документов"
        
        user -> educationSystem "Заходит на сайт"
        educationSystem -> paymentSystem "Интеграция"
        educationSystem -> mailSystem "Интеграция"
        educationSystem -> documentSystem "Интеграция"
        educationSystem -> logging "Интеграция"
        educationSystem -> monitoring "Интеграция"

        user -> webApp "Заходит на сайт" "HTTPS"
        browser -> localStorage "сохраняет cookies"
        webApp -> backend "Взаимодействует через REST API" "HTTPS"
        
        backend -> DB "Читает/записывает" "PostgreSQL/SQL"
        backend -> cache "Кэширует данные" "Redis"
        backend -> paymentSystem "API вызовы для платежей" "HTTPS/TLS"
        backend -> mailSystem "API вызовы для рассылок" "HTTPS"
        backend -> documentSystem "Взаимодействует через очередь сообщений" "RabbitMQ/AMQP"
        backend -> monitoring "Управление метриками" "API"
        backend -> logging "Отправка логов" "API"
        
        webApp -> api "Отправляет запрос" "HTTPS"
        
        api -> Auth "Маршрутизирует запросы" "API"
        api -> Profile "Маршрутизирует запросы" "API"
        api -> Subscription "Маршрутизирует запросы" "API"
        api -> Support "Маршрутизирует запросы" "API"
        api -> logComponent "Маршрутизирует запросы" "API"
        api -> monComponent "Маршрутизирует запросы" "API"
        
        Auth -> dbComponent "API"
        Profile -> dbComponent "API"
        Subscription -> dbComponent "API"
        Support -> dbComponent "API"
        
        Subscription -> paymentSystem "async REST API" "TLS"
        Auth -> mailSystem "cron job"
        Subscription -> mailSystem "cron job
        Profile -> documentSystem "RabbitMQ/AMQP"
        Support -> mailSystem "cron job"
        
        dbComponent -> db "Читает/Записывает" "Entity framework"
        dbComponent -> cache "Кеширует данные" "Entity framework"
        
        logComponent -> logging "Читает/Записывает логи" "API"
        monComponent -> monitoring "Управляет мониторингом" "API"
    }

    views {
        systemContext educationSystem {
            include *
            autoLayout tb
        }
        container educationSystem {
            include *
            autolayout tb
        }
        component webApp {
            include *
            autolayout tb
        }
        component backend {
            include *
            autolayout tb
        }
        
        theme default
        
        styles {
            element "Database" {
                shape cylinder
            }
            element "UI" {
                shape WebBrowser
            }
            element "Cache" {
                shape cylinder
            }
            element log {
                background #FF9800
            }
            element monitoring {
                background #FF9800
            }
            element "Storage" {
                shape cylinder
                width 300
                height 300
                background #FFEB3B
            }
            element "browser" {
                shape WebBrowser
            }
            element "api" {
                shape circle
            }
        }
    }
}