﻿&НаСервере
Функция ФормированиеТабличногоДокумента_Протокола(СсылкаНаОбъект, ТабДок)  Экспорт
	  
    ВозвращаемыйМассив = Новый Массив;

	Если Табдок = Неопределено  Тогда
	
		ТабДок = Новый ТабличныйДокумент;
		ТабДок.РазмерКолонтитулаСнизу	= 15;
		ТабДок.ПолеСнизу				= 20;
		ТабДок.ОриентацияСтраницы		= ОриентацияСтраницы.Портрет; 
		
	ИначеЕсли  ТабДок.ОриентацияСтраницы = ОриентацияСтраницы.Ландшафт  Тогда
		
		ВозвращаемыйМассив.Добавить(ТабДок);
		
		ТабДок = Новый ТабличныйДокумент;
		ТабДок.РазмерКолонтитулаСнизу = 15;
		ТабДок.ПолеСнизу              = 20;
		ТабДок.ОриентацияСтраницы = ОриентацияСтраницы.Портрет; 
		
	КонецЕсли;	
	 			
	#Область Получение_областей
	      	
    МакетОбработки = ПолучитьМакет("МакетЭкспертного");	
	
	ОбластьПустаяСтрока		= МакетОбработки.ПолучитьОбласть("ПустаяСтрока");    	
	ОбластьШапка			= МакетОбработки.ПолучитьОбласть("ТаблицаШапка");
	ОбластьТабЛаборатория	= МакетОбработки.ПолучитьОбласть("ТабЛаборатория");
	ОбластьТаблица			= МакетОбработки.ПолучитьОбласть("Таблица");
	
	#КонецОбласти
	
	Если ТабДок.ПроверитьВывод(ОбластьПустаяСтрока) Тогда
		
		ТабДок.Вывести(ОбластьПустаяСтрока);
		
	Иначе   
		
		ВозвращаемыйМассив.Добавить(ТабДок);
		ТабДок = Новый ТабличныйДокумент;
		ТабДок.РазмерКолонтитулаСнизу	= 10;
		ТабДок.ПолеСнизу				= 15;
		ТабДок.ОриентацияСтраницы		= ОриентацияСтраницы.Портрет;      
		ТабДок.Вывести(ОбластьПустаяСтрока);
		
	КонецЕсли;  	
	
	Если ТабДок.ПроверитьВывод(ОбластьШапка) Тогда
		
		ТабДок.Вывести(ОбластьШапка);
		
	Иначе   
		
		ВозвращаемыйМассив.Добавить(ТабДок);
		ТабДок = Новый ТабличныйДокумент;
		ТабДок.РазмерКолонтитулаСнизу	= 10;
		ТабДок.ПолеСнизу				= 15;
		ТабДок.ОриентацияСтраницы		= ОриентацияСтраницы.Портрет;      
		ТабДок.Вывести(ОбластьШапка);
		
	КонецЕсли;  	
	
	ОбластьТабЛаборатория.Параметры.Лаборатория 			 = СсылкаНаОбъект.Лаборатория;
	ОбластьТабЛаборатория.Параметры.НомерВЖурналеЛаборатории = СсылкаНаОбъект.НомерВЖурнале;
	
	Если ТабДок.ПроверитьВывод(ОбластьТабЛаборатория) Тогда
		
		ТабДок.Вывести(ОбластьТабЛаборатория);
		
	Иначе   
		
		ВозвращаемыйМассив.Добавить(ТабДок);
		ТабДок = Новый ТабличныйДокумент;
		ТабДок.РазмерКолонтитулаСнизу	= 10;
		ТабДок.ПолеСнизу				= 15;
		ТабДок.ОриентацияСтраницы		= ОриентацияСтраницы.Портрет;      
		ТабДок.Вывести(ОбластьТабЛаборатория);
		
	КонецЕсли;  	
	
	#Область тз
	
		
    ВрмеТЗМетодики = СсылкаНаОбъект.ПродуктыПоказатели.Выгрузить(,"Примечание");
	ВрмеТЗМетодики.Свернуть("Примечание");
	НовыйНД = ВрмеТЗМетодики.ВыгрузитьКолонку("Примечание");
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	_ИМЦ_ЗаменяемыеНормотивныеДокументы.СтарыйНД,
	|	_ИМЦ_ЗаменяемыеНормотивныеДокументы.НовыйНД
	|ИЗ
	|	РегистрСведений._ИМЦ_ЗаменяемыеНормотивныеДокументы КАК _ИМЦ_ЗаменяемыеНормотивныеДокументы
	|ГДЕ
	|	_ИМЦ_ЗаменяемыеНормотивныеДокументы.НовыйНД В(&НовыйНД)";
	
	Запрос.УстановитьПараметр("НовыйНД", НовыйНД);
	
	ТЗСответствияНовыхИСтарыхНД =  Запрос.Выполнить().Выгрузить();        
	
	
	Показатели = СсылкаНаОбъект.ПродуктыПоказатели.Выгрузить();
	Показатели.Свернуть("ГУИД,Показатель,Услуга,Примечание,Объем,Результат,ПродуктИсследования,РезультатСтрока, ДополнительныеСведения, НаименованиеДляПротокола, ЗначениеУсловия,Условие,РезультатУсловия,Погрешность, ЕдиницаИзмерения");
	максКолворезультатов = 1;
	НомерСтрокиВТабличнойЧасти = 10;
	щщ = 0;
	
	Для каждого Стр из Показатели Цикл
		
		щщ = щщ +1;
		//ОбластьТаблица.Параметры.НомерСтроки = щщ;
		ОбластьТаблица.Параметры.Показатель = Стр.Показатель;
		
		Если  ЗначениеЗаполнено(Стр.ЕдиницаИзмерения)   Тогда
			ОбластьТаблица.Параметры.ЕденицаИзмерения = Стр.ЕдиницаИзмерения;  
		Иначе    
		    ОбластьТаблица.Параметры.ЕденицаИзмерения = Стр.Показатель.ЕдиницаИзмерения;  
		КонецЕсли;	 
			
		ОбластьТаблица.Параметры.РезультатИзмеренийПогрешность  = Стр.РезультатСтрока;
		
		Отбор = Новый Структура("НовыйНД",  Стр.Примечание);
		НайдСтроки = ТЗСответствияНовыхИСтарыхНД.НайтиСтроки(Отбор);
		
		Если НайдСтроки.Количество() Тогда
			
			ОбластьТаблица.Параметры.НД = Строка(Стр.Примечание) + " взамен " +  НайдСтроки[0].СтарыйНД; 
			    			
		Иначе      
			
			ОбластьТаблица.Параметры.НД = Стр.Примечание; 
			    			
		КонецЕсли;	
		
		Если ТабДок.ПроверитьВывод(ОбластьТаблица) Тогда
			
			ТабДок.Вывести(ОбластьТаблица);
			
		Иначе   
			
			ВозвращаемыйМассив.Добавить(ТабДок);
			ТабДок = Новый ТабличныйДокумент;
			ТабДок.РазмерКолонтитулаСнизу	= 10;
			ТабДок.ПолеСнизу				= 15;
			ТабДок.ОриентацияСтраницы		= ОриентацияСтраницы.Портрет;      
			ТабДок.Вывести(ОбластьТаблица);
			
		КонецЕсли;  	
				     		
	КонецЦикла;  
		

	#КонецОбласти 
	
		
	
	//результаты измерений
	#Область Результаты_исследования   
	
	//Если ТабДок.ПроверитьВывод(ОбластьШапкаТаблицаРезультатыИзмерений) Тогда
	//	
	//	ТабДок.Вывести(ОбластьШапкаТаблицаРезультатыИзмерений);
	//	
	//Иначе   
	//	
	//	ВозвращаемыйМассив.Добавить(ТабДок);
	//	ТабДок = Новый ТабличныйДокумент;
	//	ТабДок.РазмерКолонтитулаСнизу = 10;
	//	ТабДок.ПолеСнизу              = 15;
	//	ТабДок.ОриентацияСтраницы = ОриентацияСтраницы.Ландшафт;      
	//	ТабДок.Вывести(ОбластьШапкаТаблицаРезультатыИзмерений);
	//	
	//КонецЕсли; 

	//	
	//Для каждого Стр Из СсылкаНаОбъект.Показатели Цикл
	//
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.Номер = стр.НомерСтроки;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.МестоИзмерения 	= Стр.ОбъектИсследования;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.Плоскость    		= Стр.Плоскость;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.Общее 	   = Стр.ИскуственнаяОсвещенностьОбщее;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.ОбщееМестное = Стр.ИскуственнаяОсвещенностьОбщееМестное;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.ОсвещенностьНорма    	= Стр.ИскуственнноеОсвещОбщееНорма;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.НаружнаяОсвещенность 	= Стр.ЕстественнаяОсвещенностьНаружная;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.КЕО      				= Стр.КЕО;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.КЕОнорма 				= Стр.КЕОНорма;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.КоэффициентПульсации      = Стр.КоэфПульсации;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.КоэффициентПульсацииНорма = Стр.КоэфПульсацииНорма;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.Ротнед      = Стр.КоэфОтражения;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.РотнедНорма = Стр.КоэфОтраженияНорма;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.НапряжениеВначале = Стр.НапряжениеВНачале;
	//	ОбластьСтрокаТаблицаРезультатыИзмерений.Параметры.НапряжениеВКонце  = Стр.НапряжениеВконце;
	//	
	//	Если ТабДок.ПроверитьВывод(ОбластьСтрокаТаблицаРезультатыИзмерений) Тогда
	//		
	//		ТабДок.Вывести(ОбластьСтрокаТаблицаРезультатыИзмерений);
	//		
	//	Иначе   
	//		
	//		ВозвращаемыйМассив.Добавить(ТабДок);
	//		ТабДок = Новый ТабличныйДокумент;
	//		ТабДок.РазмерКолонтитулаСнизу = 10;
	//		ТабДок.ПолеСнизу              = 15;
	//		ТабДок.ОриентацияСтраницы = ОриентацияСтраницы.Ландшафт;      
	//		ТабДок.Вывести(ОбластьСтрокаТаблицаРезультатыИзмерений);
	//		
	//	КонецЕсли;
	//	
	//КонецЦикла;
	//
	         	
	#КонецОбласти
	
	Возврат ВозвращаемыйМассив;
	

	
КонецФункции

&НаСервере
Функция ФормированиеТабличногоДокумента_Экспертного(СсылкаНаОбъект, ТабДок)  Экспорт
	        	
	#Область Получение_областей
	      	
    МакетОбработки = ПолучитьМакет("МакетЭкспертного");	
	
	ОбластьПустаяСтрока		= МакетОбработки.ПолучитьОбласть("ПустаяСтрока");    	
	ОбластьШапка			= МакетОбработки.ПолучитьОбласть("ТаблицаШапка");
	ОбластьТабЛаборатория	= МакетОбработки.ПолучитьОбласть("ТабЛаборатория");
	ОбластьТаблица			= МакетОбработки.ПолучитьОбласть("Таблица");
	
	#КонецОбласти
	
	ВозрСтрукт = Новый Структура;
	
	сч = 0;
	
	сч=сч+1;
	ВозрСтрукт.Вставить("ТабДок" + сч, Новый ТабличныйДокумент);
	ВозрСтрукт["ТабДок" + сч].РазмерКолонтитулаСнизу	= 10;
	ВозрСтрукт["ТабДок" + сч].ПолеСнизу				= 15;
	ВозрСтрукт["ТабДок" + сч].ОриентацияСтраницы		= ОриентацияСтраницы.Портрет;  
	ВозрСтрукт["ТабДок" + сч].Вывести(ОбластьПустаяСтрока);


	сч=сч+1; 
	ВозрСтрукт.Вставить("ТабДок" + сч, Новый ТабличныйДокумент);
	ВозрСтрукт["ТабДок" + сч].РазмерКолонтитулаСнизу	= 10;
	ВозрСтрукт["ТабДок" + сч].ПолеСнизу				= 15;
	ВозрСтрукт["ТабДок" + сч].ОриентацияСтраницы		= ОриентацияСтраницы.Портрет;  
	ВозрСтрукт["ТабДок" + сч].Вывести(ОбластьШапка);

	
	ОбластьТабЛаборатория.Параметры.Лаборатория 			 = СсылкаНаОбъект.Лаборатория;
	ОбластьТабЛаборатория.Параметры.НомерВЖурналеЛаборатории = СсылкаНаОбъект.НомерВЖурнале;
	
	сч=сч+1;   
	ВозрСтрукт.Вставить("ТабДок" + сч, Новый ТабличныйДокумент);
	ВозрСтрукт["ТабДок" + сч].РазмерКолонтитулаСнизу	= 10;
	ВозрСтрукт["ТабДок" + сч].ПолеСнизу				= 15;
	ВозрСтрукт["ТабДок" + сч].ОриентацияСтраницы		= ОриентацияСтраницы.Портрет;  
	ВозрСтрукт["ТабДок" + сч].Вывести(ОбластьТабЛаборатория);
 	
	
	#Область тз
	
	Отбор = Новый Структура("Печать", Истина); 
	Найденные = СсылкаНаОбъект.ПродуктыПоказатели.НайтиСтроки(Отбор);
	Для каждого Стр из Найденные Цикл
		
		ОбластьТаблица.Параметры.Показатель = Стр.Показатель;
		ОбластьТаблица.Параметры.ЕдИзмер    = Стр.Показатель.ЕдиницаИзмерения;
		ОбластьТаблица.Параметры.Результат 	= ДобавитьСимволСтепень(Стр.РезультатСтрока); 
		ОбластьТаблица.Параметры.Норма 		= ДобавитьСимволСтепень(Стр.Объем); 
		ОбластьТаблица.Параметры.НД 		= Стр.Примечание; 
		
		сч=сч+1;   
		ВозрСтрукт.Вставить("ТабДок" + сч, Новый ТабличныйДокумент);
		ВозрСтрукт["ТабДок" + сч].РазмерКолонтитулаСнизу	= 10;
		ВозрСтрукт["ТабДок" + сч].ПолеСнизу				= 15;
		ВозрСтрукт["ТабДок" + сч].ОриентацияСтраницы		= ОриентацияСтраницы.Портрет;  
		ВозрСтрукт["ТабДок" + сч].Вывести(ОбластьТаблица);
		
		
	КонецЦикла;		

	#КонецОбласти 
	
		
	
	//результаты измерений
	#Область Результаты_исследования   
	 	         	
	#КонецОбласти
	
	Возврат ВозрСтрукт;

	
КонецФункции

Функция ДобавитьСимволСтепень(Входящая)
	
	Первая = Найти(Входящая,"@");
	Если Первая > 0 Тогда
		
		Если Найти(Входящая,"@2@") > 0 Тогда
			Исходящая = СтрЗаменить(Входящая,"@2@",Символ(178));
		ИначеЕсли Найти(Входящая,"@3@") > 0 Тогда
			//Исходящая = СтрЗаменить(Входящая,"@3@",Символ(179));
			Исходящая = СтрЗаменить(Входящая,"@3@","³");
		ИначеЕсли Найти(Входящая,"@4@") > 0 Тогда
			Исходящая = СтрЗаменить(Входящая,"@4@",Символ(8308));
		ИначеЕсли Найти(Входящая,"@5@") > 0 Тогда
			Исходящая = СтрЗаменить(Входящая,"@5@",Символ(8309));
		ИначеЕсли Найти(Входящая,"@6@") > 0 Тогда
			Исходящая = СтрЗаменить(Входящая,"@6@",Символ(8310));
		ИначеЕсли Найти(Входящая,"@7@") > 0 Тогда
			Исходящая = СтрЗаменить(Входящая,"@7@",Символ(8311));
		ИначеЕсли Найти(Входящая,"@8@") > 0 Тогда
			Исходящая = СтрЗаменить(Входящая,"@8@",Символ(8312));
		ИначеЕсли Найти(Входящая,"@9@") > 0 Тогда
			Исходящая = СтрЗаменить(Входящая,"@9@",Символ(8313));
		КонецЕсли;
		
		Если Найти(Входящая,"@") Тогда 
			Исходящая = ДобавитьСимволСтепень(Исходящая);
		КонецЕсли;	

	Иначе
		Исходящая = Входящая;
	КонецЕсли;	
	
	Возврат Исходящая;
	
КонецФункции	
