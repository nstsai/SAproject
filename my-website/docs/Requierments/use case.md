---
title: Use Case diagram
sidebar_position: 2
---

# Use Case diagram

В данном разделе приведена Use Case диаграмма для описания сценариев 

```plantuml

@startuml

left to right direction

actor "Пользователь" as c
actor "Учитель" as u
c <|-- u
actor "Служба поддержки" as s

package "Регистрация/авторизация" {
usecase "Открыть раздел входа" as UC14
usecase "Ввести email" as UC15
usecase "Подтвердить email" as UC16
usecase "Ввести пароль" as UC17
usecase "Придумать пароль" as UC18
usecase "Восстановить пароль" as UC19
usecase "Войти в аккаунт" as UC20
}

c --> UC14
c --> UC15
c --> UC16
c --> UC17
UC17 <.. UC18:include
UC17 <.. UC19:extend
c --> UC20

package "Личный кабинет" {
usecase "Заполнить анкету" as UC21
usecase "Ввести имя" as UC22
usecase "Ввести фамилия" as UC23
usecase "Ввести возраст" as UC24
usecase "Указать роль" as UC25
usecase "Выбрать предмет" as UC26
usecase "Добавить фото" as UC28
usecase "Заменить фото" as UC30
usecase "Удалить фото" as UC31
usecase "Дать согласие на обр.данных" as UC29
usecase "Сохранить данные" as UC27
}

c --> UC21
UC21 ..> UC22: include
UC21 ..> UC23: include
UC21 ..> UC24: include
UC21 ..> UC25: include
UC25 <.. UC26: extend
c --> UC27
c --> UC28
UC28 <.. UC30: extend
UC28 <.. UC31: extend
c --> UC29

package "Профиль учителя" {
usecase "Заполнить раздел "о себе"" as UC32
usecase "Добавить профессиональный опыт" as UC33
usecase "Подтвердить опыт" as UC34
usecase "Загрузить документы" as UC35
usecase "Добавить уроки" as UC36
usecase "Редактировать" as UC38
usecase "Сделать публикацию" as UC37
usecase "Редактировать" as UC39
}

u --> UC32
u --> UC33
UC33 <.. UC34: extend
UC34 ..> UC35: include
u --> UC36
UC36 <.. UC38: extend
u --> UC37
UC37 <.. UC39: extend

package "База знаний" {
usecase "Открыть вкладку "База знаний"" as UC40
usecase "Просмотреть разделы" as UC41
usecase "Редактировать разделы" as UC42
usecase "Создать раздел" as UC43
usecase "Добавить обложку" as UC44
usecase "Добавить текст" as UC45
usecase "Загрузить файлы" as UC46
}

u --> UC40
u --> UC41
u --> UC42
u --> UC43
UC43 <.. UC44: extend
UC43 <.. UC45: extend
UC43 <.. UC46: extend

package "Оформление подписки" {
usecase "Открыть раздел подписка" as UC1
usecase "Изучить условия подписки" as UC2
usecase "Выбрать тип подписки" as UC3
usecase "Задать вопрос поддержке" as UC4
usecase "Ввести данные для оплаты" as UC5
usecase "Ввести номер карты" as UC6
usecase "Ввести срок действия карты" as UC7
usecase "Ввести CVC-код" as UC8
usecase "Оплатить подписку" as UC9
usecase "Оформить подписку" as UC10
usecase "Отменить подписку" as UC11
usecase "Получить вопрос от клиента" as UC12
usecase "Ответить на вопрос клиента" as UC13
}

u --> UC1
u --> UC2
u --> UC3
UC2 <.. UC4: extend
u --> UC5
UC5 ..> UC6: include
UC5 ..> UC7: include
UC5 ..> UC8: include
u --> UC9
u --> UC10
UC10 <.. UC11: extend
s --> UC12
s --> UC13

@enduml
