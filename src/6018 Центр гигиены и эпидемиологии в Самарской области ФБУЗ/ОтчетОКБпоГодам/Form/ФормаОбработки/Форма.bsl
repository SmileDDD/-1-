﻿НаСервере
Процедура СформироватьНаСервере()
	
	СписокПоказателей = ПолучитьМасПоказатлей();
	
	 Запрос = Новый Запрос;
	 Запрос.Текст = "ВЫБРАТЬ
	                |	ГОД(_ИМЦ_РезультатыИсследований.Регистратор.Дата) КАК Год,
	                |	СУММА(ВЫБОР
	                |			КОГДА _ИМЦ_РезультатыИсследований.Значение < 50
	                |				ТОГДА 1
	                |			ИНАЧЕ 0
	                |		КОНЕЦ) КАК КолДо50,
	                |	СУММА(ВЫБОР
	                |			КОГДА _ИМЦ_РезультатыИсследований.Значение >= 50
	                |					И _ИМЦ_РезультатыИсследований.Значение < 500
	                |				ТОГДА 1
	                |			ИНАЧЕ 0
	                |		КОНЕЦ) КАК КолДо500,
	                |	СУММА(ВЫБОР
	                |			КОГДА _ИМЦ_РезультатыИсследований.Значение > 500
	                |					И _ИМЦ_РезультатыИсследований.Значение <= 1000
	                |				ТОГДА 1
	                |			ИНАЧЕ 0
	                |		КОНЕЦ) КАК КолДо1000,
	                |	СУММА(ВЫБОР
	                |			КОГДА _ИМЦ_РезультатыИсследований.Значение > 1000
	                |				ТОГДА 1
	                |			ИНАЧЕ 0
	                |		КОНЕЦ) КАК КолБолее1000
	                |ИЗ
	                |	РегистрСведений._ИМЦ_РезультатыИсследований КАК _ИМЦ_РезультатыИсследований
	                |ГДЕ
	                |	_ИМЦ_РезультатыИсследований.Показатель = &Показатель
	                |	И _ИМЦ_РезультатыИсследований.Регистратор.Дата > &Дата
	                |	И _ИМЦ_РезультатыИсследований.ПродуктИсследования = &ПродуктИсследования
	                |	И _ИМЦ_РезультатыИсследований.Лаборатория = &Лаборатория
	                |
	                |СГРУППИРОВАТЬ ПО
	                |	ГОД(_ИМЦ_РезультатыИсследований.Регистратор.Дата)";
	 Запрос.УстановитьПараметр("Показатель", Показатель);
	 Запрос.УстановитьПараметр("Дата", дАТА);  //ДобавитьМесяц(ТекущаяДата(),-60)
	 Запрос.УстановитьПараметр("ПродуктИсследования", ОбъектИсследования);
	 Запрос.УстановитьПараметр("Лаборатория", Лаборатория);
	
	
	
	 Результат =  Запрос.Выполнить().Выгрузить();
	 
	 Если Результат.Количество() Тогда
		 
		 ЭтОбъект = РеквизитФормыВЗначение("Объект");
		 МакетОбработки = ЭтОбъект.ПолучитьМакет("Макет");
		 ОбластьЗаголовок = МакетОбработки.ПолучитьОбласть("Заголовок");
		 ТабДок.Вывести(ОбластьЗаголовок);
		 
		 Для Каждого Стр Из Результат Цикл
			 
			 ОбластьСтрока = МакетОбработки.ПолучитьОбласть("Строка");
				ОбластьСтрока.Параметры.Заполнить(Стр); 
			 ТабДок.Вывести(ОбластьСтрока);
			 
		 КонецЦикла;
		 
	 КонецЕсли;

	
	
КонецПроцедуры

&НаСервере
Функция ПолучитьМасПоказатлей()
	
	мас = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	_ИМЦ_ПланВидовХарактеристикПоказателей.Ссылка
	|ИЗ
	|	ПланВидовХарактеристик._ИМЦ_ПланВидовХарактеристикПоказателей КАК _ИМЦ_ПланВидовХарактеристикПоказателей
	|ГДЕ
	|	_ИМЦ_ПланВидовХарактеристикПоказателей.Наименование = &Наименование";
	
	Запрос.УстановитьПараметр("Наименование", ПоказательНаименование);
	
	Результат =  Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	Возврат Результат; 
	
КонецФункции

