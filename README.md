# Модель распределения суммы по базе

## Описание

Реализация DSL для решения задач распределения. Объектами распределения являются таблицы.

Структура таблиц в общем случае представлена полями: измерения, ресурсы, реквизиты. Таблица распределения соединяется по полям измерений с таблице базы распределения. Суммы ресурсов распределяются по базе.

Если ресурсов несколько, то первый является суммой всех остальных. Допускается распределять либо равное количество ресурсов, либо 1 к N или N к 1.

Для описания модели распределения используется свой DSL. Принцип работы DSL: описывается модель в декларативном виде. Для описания модели используется текучий интерфейс.

Результат распределения можно получить из модели после выполнения метода модели Распределить(). Этот метод аналогичен методу запроса Выполнить(). После выполнения метода модель очищается, но остается досутпным результат:

- РезультатРаспределения - результат
- ТаблицаРаспределения - нераспределенный остаток таблицы распределения
- БазаРаспределения - нераспределенный остаток базы

## Примеры

### Распределение товаров по партиям

	МодельЗапроса = Общий.МодельЗапроса()
	;
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_ТОВАРЫ")
		.Источник(Объект.Товары)
		.Поле("*")
	;
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_ПАРТИИ")
		.Источник(Объект.Партии)
		.Поле("*")
	;
	МодельЗапроса.ВыполнитьЗапрос();
	
	МодельРаспределения = Общий.МодельРаспределения(МодельЗапроса.МенеджерВременныхТаблиц);
	МодельРаспределения
		.Таблица("ВТ_ТОВАРЫ")
			.Измерения()
				.Поле("Товар")
			.Реквизиты()
				.Поле("*")
			.Ресурсы()
				.Поле("Количество")
		.База("ВТ_ПАРТИИ")
			.Измерения()
				.Поле("*")
			.Реквизиты()
				.Поле("*")
			.Ресурсы()
				.Поле("Количество")
			.Порядок("ДатаПартии")
	;
	МодельРаспределения.Распределить();
	
	ВывестиТаблицу(Результат, МодельРаспределения.РезультатРаспределения, "Распределение по партиям");
	ВывестиТаблицу(Результат, МодельРаспределения.БазаРаспределения, "Не распределенные остатки по партиям");
	ВывестиТаблицу(Результат, МодельРаспределения.ТаблицаРаспределения, "Нераспределенные остатки товаров");

Смотрите описание в статье на Инфостарт:
- [Модель распределения суммы по базе](https://infostart.ru/1c/tools/1620797/)
- [Ограничения в модели распределения. Переопределение результата](https://infostart.ru/1c/articles/1942685/)

![Инфостарт](https://infostart.ru/bitrix/templates/sandbox_empty/assets/tpl/abo/img/logo.svg)
