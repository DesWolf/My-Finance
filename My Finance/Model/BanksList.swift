//
//  BanksList.swift
//  My Finance
//
//  Created by Максим Окунеев on 1/8/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

class Banklist {
    
    static let bankNames = ["Сбербанк России","-=Нет в списке=-", "Абсолют Банк", "Авангард", "Аверс", "Автоградбанк", "АвтоКредитБанк", "Автоторгбанк", "АГОРА", "Агропромкредит", "Агророс", "Азиатско-Тихоокеанский Банк", "АЗИЯ-ИНВЕСТ БАНК", "АйСиБиСи Банк", "АК Барс", "Акибанк", "АКРОПОЛЬ", "Актив Банк", "Александровский", "Алеф-Банк", "Алмазэргиэнбанк", "Алтайкапиталбанк", "Алтынбанк", "АЛЬБА АЛЬЯНС", "АЛЬТЕРНАТИВА", "Альфа-Банк", "АМЕРИКЭН ЭКСПРЕСС БАНК", "АО КОШЕЛЕВ-БАНК", "АПАБАНК", "АРЕСБАНК", "Арзамас", "БайкалИнвестБанк", "Байкалкредобанк", "Балаково-Банк", "Балтийский Банк Развития", "Балтинвестбанк", "Банк «Объединенный капитал»", "Банк «Приморье»", "Банк Акцепт", "Банк ДОМ.РФ", "Банк Жилищного Финансирования", "Банк Интеза", "Банк Казани", "БАНК КИТАЯ (ЭЛОС)", "Банк Корпоративного Финансирования", "БАНК МИА (Московское ипотечное агентство)", "Банк Москвы", "Банк Оранжевый", "БАНК ПСА ФИНАНС РУС", "БАНК РАУНД", "Банк Реалист", "Банк РМП", "БАНК РСИ", "Банк Русский Стандарт", "Банк СКС", "Банк Финсервис", "Банк Хоум Кредит", "Банк ЧБРР", "Белгородсоцбанк", "Берейт", "Бест Эффортс Банк", "БКС Банк", "БМВ БАНК", "БНП Париба", "Братский народный банк", "БСТ-Банк", "БыстроБанк", "Вакобанк", "Великие Луки Банк", "Венец", "Веста", "Викинг", "Витабанк", "Вкабанк", "Владбизнесбанк", "Внешфинбанк", "Возрождение", "Вокбанк", "Вологжанин", "Восточный Банк", "Всероссийский Банк Развития Регионов", "ВТБ", "ВУЗ-Банк", "Вятич", "Газнефтьбанк", "Газпромбанк", "Газтрансбанк", "Газэнергобанк", "Гарант-Инвест", "Генбанк", "ГЕОБАНК", "Гефест", "ГЛОБУС", "Гута-Банк", "ДАЛЕНА", "Дальневосточный Банк", "Девон-Кредит", "ДЕНИЗБАНК МОСКВА", "ДЕРЖАВА", "Джей энд Ти Банк", "Долинск", "ДОМ-БАНК", "Дон-Тексбанк", "Донкомбанк", "Дружба", "ЕАТП Банк", "ЕВРАЗИЙСКИЙ БАНК", "Евроазиатский Инвестиционный Банк", "Евроальянс", "Екатеринбург", "Енисейский Объединенный Банк", "Ермак", "Живаго-Банк", "Запсибкомбанк", "Заречье", "Заубер Банк", "Земкомбанк", "Земский Банк", "ЗЕНИТ", "Зенит Сочи", "ЗИРААТ БАНК (МОСКВА)", "Ижкомбанк", "ИК Банк", "ИНБАНК", "Инвестторгбанк", "ИнтерПрогрессБанк", "Интерпромбанк", "ИРС", "ИС БАНК", "ИТ Банк", "Йошкар-Ола", "ИШБАНК", "Калуга", "Камский Коммерческий Банк", "КАПИТАЛ", "Кетовский Коммерческий Банк", "Киви Банк", "Классик Эконом Банк", "Кольцо Урала", "КОММЕРЦБАНК (ЕВРАЗИЯ)", "Консервативный Коммерческий Банк", "Континенталь", "КОСМОС", "Костромаселькомбанк", "Крайинвест", "Кредит Европа Банк", "Кредит Урал Банк", "КРЕМЛЕВСКИЙ", "КРОКУС-БАНК", "Крона-Банк", "КРОСНА-БАНК", "КС Банк", "Кубань Кредит", "Кубаньторгбанк", "Кузбассхимбанк", "Кузнецкбизнесбанк", "Кузнецкий", "КУЗНЕЦКИЙ МОСТ", "Курган", "Курскпромбанк", "ЛАНТА-БАНК", "Левобережный", "Липецккомбанк", "ЛОКО-Банк", "Майкопбанк", "Майский", "МВС Банк", "Мегаполис", "Международный Банк Азербайджана", "МЕЖДУНАРОДНЫЙ ФИНАНСОВЫЙ КЛУБ", "Металлинвестбанк", "Металлург", "Меткомбанк (Каменск-Уральский)", "МИР БИЗНЕС БАНК", "МКБ", "Морской Банк", "МОСКВА-СИТИ", "Московский Индустриальный Банк", "МОСКОВСКИЙ КОММЕРЧЕСКИЙ БАНК", "Московский Кредитный Банк", "Московский Нефтехимический Банк", "Москоммерцбанк", "Мособлбанк", "МС Банк Рус", "МТИ-БАНК", "МТС-Банк", "Муниципальный Камчатпрофитбанк", "Мурманский Социальный Коммерческий Банк", "Нальчик", "Народный Банк", "Народный Банк Республики Тыва", "НАРОДНЫЙ ДОВЕРИТЕЛЬНЫЙ БАНК", "Народный Инвестиционный Банк", "Нацинвестпромбанк", "Национальный Банк Сбережений", "НАЦИОНАЛЬНЫЙ РЕЗЕРВНЫЙ БАНК", "Национальный стандарт", "НБД-Банк", "Невастройинвест", "Нейва", "Нефтепромбанк", "Нижневолжский Коммерческий Банк", "Нико-Банк", "НК Банк", "Новикомбанк", "Новобанк", "Новокиб", "НОВЫЙ ВЕК", "НОВЫЙ МОСКОВСКИЙ БАНК", "Нокссбанк", "Ноосфера", "Норвик Банк", "Нордеа Банк", "НС Банк", "НЭКЛИС-БАНК", "Объединенный Банк Республики", "Онего", "ОНЕЙ БАНК", "ООО КБ „СИНКО-БАНК“", "ОРБАНК", "ОРГБАНК", "Оренбург", "ОТП Банк", "ПАО Банк «ФК Открытие»", "Первоуральскбанк", "Первый Дортрансбанк", "Первый Инвестиционный Банк", "ПЕРВЫЙ КЛИЕНТСКИЙ БАНК", "Пермь", "Петербургский городской банк", "Петербургский Социальный Коммерческий Банк", "Платежный центр", "ПЛАТИНА", "Плюс Банк", "Пойдем!", "Почта Банк", "Почтобанк", "Приморский Территориальный", "Примсоцбанк", "Прио-Внешторгбанк", "Приобье", "Проинвестбанк", "ПРОКОММЕРЦБАНК", "Проминвестбанк", "Промсельхозбанк", "ПромТрансБанк", "Промышленно-Финансовое Сотрудничество - Банк", "Профессионал Банк", "Прохладный", "Развитие-Столица", "Райффайзенбанк", "РБА", "Ренессанс Кредит", "РЕНТА-БАНК", "РЕСО КРЕДИТ", "РЕСУРС-ТРАСТ", "РН Банк", "Росбанк", "РОСБИЗНЕСБАНК", "Росгосстрах Банк", "РосДорБанк", "Роскосмосбанк", "РоссельхозБанк", "РОССИЙСКИЙ НАЦИОНАЛЬНЫЙ КОММЕРЧЕСКИЙ БАНК", "РОССИТА-БАНК", "Россия", "Ростфинанс", "РОСЭКСИМБАНК", "Роял Кредит Банк", "Руна-Банк", "Руснарбанк", "Русский Банк Сбережений", "Русфинанс Банк", "Русь", "РУСЬУНИВЕРСАЛБАНК", "РФИ БАНК", "Саммит Банк", "Санкт-Петербург", "Саратов", "Саровбизнесбанк", "Сбербанк России", "Связь-Банк", "СДМ-Банк", "Севастопольский Морской банк", "Севергазбанк", "Северный Народный Банк", "Северстройбанк", "Севзапинвестпромбанк", "Сельмашбанк", "СЕРВИС-РЕЗЕРВ", "Сетелем", "СИАБ", "Сибсоцбанк", "Синергия", "СИСТЕМА", "Сити Инвест Банк", "Ситибанк", "СКБ-Банк", "СЛАВИЯ", "СЛАВЯНСКИЙ КРЕДИТ", "СМП Банк", "Снежинский", "Собинбанк", "Совкомбанк", "СОВРЕМЕННЫЕ СТАНДАРТЫ БИЗНЕСА", "СОКОЛОВСКИЙ", "Солид Банк", "Солидарность (Самара)", "СОЦИУМ-БАНК", "Союз", "СПЕЦСТРОЙБАНК", "Спиритбанк", "Спутник", "Ставропольпромстройбанк", "Стандарт-Кредит", "СТОЛИЧНЫЙ КРЕДИТ", "Стройлесбанк", "Сургутнефтегазбанк", "СЭБ Банк", "Таврический", "Таганрогбанк", "Тайдон", "Тамбовкредитпромбанк", "Татсоцбанк", "Тексбанк", "ТЕНДЕР-БАНК", "Тинькофф Банк", "Тойота Банк", "Тольяттихимбанк", "Томскпромстройбанк", "Торжокуниверсалбанк", "Транскапиталбанк", "Трансстройбанк", "ТРАСТ", "ТЭМБР-Банк", "Углеметбанк", "Урал ФД", "Уралпромбанк", "Уралсиб", "Уралфинанс", "Уральский Банк Реконструкции и Развития", "УРИ БАНК", "Финам Банк", "Финанс Бизнес Банк", "ФОЛЬКСВАГЕН БАНК РУС", "Форабанк", "Форбанк", "Форштадт", "Фридом Финанс", "Хакасский Муниципальный Банк", "Химик", "Хлынов", "Холмск", "Центр-инвест", "Центрально-Азиатский", "ЦЕНТРОКРЕДИТ", "ЧАЙНА КОНСТРАКШН БАНК", "Челиндбанк", "Челябинвестбанк", "ЭКО-ИНВЕСТ", "Экономбанк", "Экси-Банк", "Экспобанк", "Экспресс-Волга", "Элита", "Энергобанк", "Энергомашбанк", "Энерготрансбанк", "Эс-Би-Ай Банк", "Юг-Инвестбанк", "ЮМК", "ЮниКредит Банк", "ЮНИСТРИМ", "Яринтербанк"]
}
