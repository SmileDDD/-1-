﻿
//======================================================================================================================

#Область ОбРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	
	  Организация = ПараметрыСеанса.ТекущийПользователь._ИМЦ_Организация;
	  Подразделение = ПараметрыСеанса.ТекущийПользователь.Подразделение;
	
	                      "ВЫБРАТЬ
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.КодПробы,
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.НомерНаправления,
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Контрагент,
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.ЗаявкаНаИсследование,
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.ДополнительныеСведения,
	                      |	_ИМЦ_РезультатыИсследований.ДатаВыдачиРезультата,
	                      |	_ИМЦ_Связь_Протокол_КодПробы_НомерНаправления.Регистратор КАК Протокол,
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.ДатаОтправленияВЛабораторию,
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Дата,
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка КАК ОбщееНаправление,
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Подразделение,
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка._ИМЦ_Организация,
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Ответственный,
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Лаборатория
	                      |ИЗ
	                      |	Документ._ИМЦ_ОбщееНаправление.ИсследованияПоЛабораториям КАК _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений._ИМЦ_РезультатыИсследований КАК _ИМЦ_РезультатыИсследований
	                      |			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений._ИМЦ_Связь_Протокол_КодПробы_НомерНаправления КАК _ИМЦ_Связь_Протокол_КодПробы_НомерНаправления
	                      |			ПО _ИМЦ_РезультатыИсследований.ОбщееНаправление._ИМЦ_Организация = _ИМЦ_Связь_Протокол_КодПробы_НомерНаправления.Организация
	                      |				И _ИМЦ_РезультатыИсследований.КодКонтрагента = _ИМЦ_Связь_Протокол_КодПробы_НомерНаправления.КодПробы
	                      |		ПО _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.КодПробы = _ИМЦ_РезультатыИсследований.КодКонтрагента
	                      |			И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка = _ИМЦ_РезультатыИсследований.ОбщееНаправление
	                      |			И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Лаборатория = _ИМЦ_РезультатыИсследований.Лаборатория
	                      |ГДЕ
	                      |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Лаборатория ССЫЛКА Справочник._ИМЦ_Лаборатории
	                      |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.НомерНаправления <> 0
	                      |	И _ИМЦ_РезультатыИсследований.ДатаВыдачиРезультата >= &ДатаВыдачиРезультатаНачало
	                      |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Дата >= &ДатаНачало
	                      |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Ответственный = &Ответственный
	                      |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Подразделение В ИЕРАРХИИ(&Подразделение)
	                      |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка._ИМЦ_Организация = &_ИМЦ_Организация
	                      |	И _ИМЦ_Связь_Протокол_КодПробы_НомерНаправления.Регистратор = ЗНАЧЕНИЕ(Документ._ИМЦ_ЕдиныйПротокол.ПустаяСсылка)
	                      |	И _ИМЦ_РезультатыИсследований.ДатаВыдачиРезультата <= &ДатаВыдачиРезультатаОкончание
	                      |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Дата <= &ДатаОкончание"
	
	//выполненные сегодня
	Список.Параметры.УстановитьЗначениеПараметра("ДатаВыдачиРезультатаНачало", НачалоДня(ТекущаяДата()); 
	
	//Список.Отбор.Элементы[0].ПравоеЗначение = НачалоДня(ТекущаяДата());
	//Список.Отбор.Элементы[0].Использование  = Истина;
    Выполненные = "ЗаСегодня";

	
	//отбор по пользователю
	Список.Параметры.УстановитьЗначениеПараметра("Ответственный", ПараметрыСеанса.ТекущийПользователь); 
	//Список.Отбор.Элементы[2].ПравоеЗначение = ПараметрыСеанса.ТекущийПользователь;
	//Список.Отбор.Элементы[2].Использование  = Истина;

	Мои = Истина;
	
	//отбор по подразделению
	Если  ЗначениеЗаполнено(Подразделение)  Тогда
		Список.Параметры.УстановитьЗначениеПараметра("Ответственный", Подразделение); 
		//Список.Отбор.Элементы[3].ПравоеЗначение = ПараметрыСеанса.ТекущийПользователь.Подразделение;
		//Список.Отбор.Элементы[3].Использование  = Истина; 
		
	Иначе
		Список.ТекстЗапроса = СтрЗаменить(Список.ТекстЗапроса, 	"
		|И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Подразделение = &Подразделение", "");

	КонецЕсли;	  	

	//отбор по организации
	Список.Параметры.УстановитьЗначениеПараметра("_ИМЦ_Организация",Организация); 
	//Если ПараметрыСеанса.ТекущийПользователь.УстанавливатьОтборПоУчреждению  Тогда   
	//	
	//	Список.Отбор.Элементы[4].ПравоеЗначение = ПараметрыСеанса.ТекущийПользователь._ИМЦ_Организация;
	//	Список.Отбор.Элементы[4].Использование  = Истина;       		
	//	
	//КонецЕсли;   
	
	НеОтображатьСПротоколами = Истина;
	
	ПериодДляТЗ_БезКода.ДатаНачала 		= НачалоДня(ТекущаяДата());
	ПериодДляТЗ_БезКода.ДатаОкончания 	= КонецДня(ТекущаяДата());
	ТолькоВыполненные = Истина;
	Если РольДоступна("ПолныеПрава") Тогда     		
		Элементы.Подразделение.Видимость	= Истина;
		Элементы.Организация.Видимость		= Истина;
	КонецЕсли;
	
	
КонецПроцедуры

#КонецОбласти

#Область Кодированые

#Область ОБРАБОТЧИКИ_СОБЫТИЙ_ЭЛЕМЕНТОВ_ФОРМЫ_С_Кодами

&НаКлиенте
Процедура ВыполненныеПриИзменении(Элемент)
	
	Если  ЗначениеЗаполнено(Выполненные)   Тогда
		
	    НеВыполненные = "";    				
		Список.Отбор.Элементы[1].Использование  = Ложь; 
	
	КонецЕсли;
	
	Если Выполненные = "ЗаСегодня"  Тогда
		
		Список.Отбор.Элементы[0].ПравоеЗначение = НачалоДня(ТекущаяДата());
		Список.Отбор.Элементы[0].Использование  = Истина;     
	
	ИначеЕсли Выполненные = "ЗаНеделю"  Тогда
		
		Список.Отбор.Элементы[0].ПравоеЗначение = НачалоДня(ТекущаяДата() - 604800);
		Список.Отбор.Элементы[0].Использование  = Истина;     
		
		
	ИначеЕсли Выполненные = "ЗаМесяц"  Тогда
		
		Список.Отбор.Элементы[0].ПравоеЗначение = НачалоДня(ДобавитьМесяц(ТекущаяДата(),-1));   
		Список.Отбор.Элементы[0].Использование  = Истина; 			
		
	КонецЕсли;
	
	ВыполненныеПериод.ДатаНачала      = '00010101';
	ВыполненныеПериод.ДатаОкончания   = '00010101';
	НеВыполненныеПериод.ДатаНачала    = '00010101';
	НеВыполненныеПериод.ДатаОкончания = '00010101';

	//Список.Отбор.Элементы[6].Использование  = Ложь;
	//Список.Отбор.Элементы[7].Использование  = Ложь;
	
	УстановкаПараметровДинамическогоСписка()
	
КонецПроцедуры

&НаКлиенте
Процедура НеВыполненныеПриИзменении(Элемент)
	
	Если  ЗначениеЗаполнено(НеВыполненные)   Тогда
		
	    Выполненные = "";
		Список.Отбор.Элементы[0].Использование  = Ложь;     
	
	КонецЕсли;  
	
	Если НеВыполненные = "ЗаНеделю"  Тогда
		
		Список.Отбор.Элементы[1].ПравоеЗначение = НачалоДня(ТекущаяДата() - 604800);
		Список.Отбор.Элементы[1].Использование  = Истина;     
		
		
	ИначеЕсли НеВыполненные = "ЗаМесяц"  Тогда
		
		Список.Отбор.Элементы[1].ПравоеЗначение = НачалоДня(ДобавитьМесяц(ТекущаяДата(),-1));   
		Список.Отбор.Элементы[1].Использование  = Истина; 			
		
	КонецЕсли;
	
	ВыполненныеПериод.ДатаНачала      = '00010101';
	ВыполненныеПериод.ДатаОкончания   = '00010101';
	НеВыполненныеПериод.ДатаНачала    = '00010101';
	НеВыполненныеПериод.ДатаОкончания = '00010101';
    Список.Отбор.Элементы[6].Использование  = Ложь;
	Список.Отбор.Элементы[7].Использование  = Ложь;

КонецПроцедуры

&НаКлиенте
Процедура ВыполненныеПериодПриИзменении(Элемент)
	
	
	Если ЗначениеЗаполнено(ВыполненныеПериод)  Тогда
		
		Если не ЗначениеЗаполнено(ВыполненныеПериод.ДатаНачала)   Тогда
			
			ВыполненныеПериод.ДатаНачала = ТекущаяДата();       
			
		КонецЕсли;	
		
		Если не ЗначениеЗаполнено(ВыполненныеПериод.ДатаОкончания)  Тогда
			
			ВыполненныеПериод.ДатаОкончания = ТекущаяДата();
			
		КонецЕсли;	
		
		Список.Отбор.Элементы[0].ПравоеЗначение = НачалоДня(ВыполненныеПериод.ДатаНачала);
		Список.Отбор.Элементы[0].Использование  = Истина;   
		Список.Отбор.Элементы[6].ПравоеЗначение = КонецДня(ВыполненныеПериод.ДатаОкончания);
		Список.Отбор.Элементы[6].Использование  = Истина;   
		
		НеВыполненныеПериод.ДатаНачала    = '00010101';
		НеВыполненныеПериод.ДатаОкончания = '00010101';

		Выполненные = "";

		Список.Отбор.Элементы[1].Использование  = Ложь;
		Список.Отбор.Элементы[7].Использование  = Ложь;   	
		
		НеВыполненные = "";

		
	Иначе
		Выполненные = "ЗаСегодня";
		НеВыполненные = "";

		
		Список.Отбор.Элементы[0].ПравоеЗначение = НачалоДня(ТекущаяДата());
		Список.Отбор.Элементы[0].Использование  = Истина;     

	    Список.Отбор.Элементы[1].Использование  = ложь;  
		Список.Отбор.Элементы[6].Использование  = ложь;  
		Список.Отбор.Элементы[7].Использование  = ложь;
		
	КонецЕсли;
	 
	
КонецПроцедуры


&НаКлиенте
Процедура НеВыполненныеПериодПриИзменении(Элемент)
		
	Если ЗначениеЗаполнено(НеВыполненныеПериод)  Тогда
		
		Список.Отбор.Элементы[1].ПравоеЗначение = НачалоДня(НеВыполненныеПериод.ДатаНачала);
		Список.Отбор.Элементы[1].Использование  = Истина;   
		Список.Отбор.Элементы[7].ПравоеЗначение = КонецДня(НеВыполненныеПериод.ДатаОкончания);
		Список.Отбор.Элементы[7].Использование  = Истина;   
		
		ВыполненныеПериод.ДатаНачала    = '00010101';
		ВыполненныеПериод.ДатаОкончания = '00010101'; 		
		  
		Выполненные   = "";
		Список.Отбор.Элементы[0].Использование  = Ложь;
		Список.Отбор.Элементы[6].Использование  = Ложь;
		НеВыполненные = "";

		
	Иначе
		
		Выполненные   = "ЗаСегодня";
		НеВыполненные = "";

		
		Список.Отбор.Элементы[0].ПравоеЗначение = НачалоДня(ТекущаяДата());
		Список.Отбор.Элементы[0].Использование  = Истина;     

	    Список.Отбор.Элементы[1].Использование  = ложь;
		Список.Отбор.Элементы[6].Использование  = ложь;  
		Список.Отбор.Элементы[7].Использование  = ложь;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура МоиПриИзменении(Элемент)
	
	Если Мои  Тогда   		
		//отбор по пользователю
		Список.Отбор.Элементы[2].ПравоеЗначение = ПолучитьПользователя();
		Список.Отбор.Элементы[2].Использование  = Истина;     		
		
	Иначе
		
		Список.Отбор.Элементы[2].Использование  = Ложь;
		
	КонецЕсли;  	
	
КонецПроцедуры

&НаКлиенте
Процедура НеОтображатьСпротоколамиПриИзменении(Элемент)
	
	Если НеОтображатьСпротоколами  Тогда  		
		Список.Отбор.Элементы[5].Использование  = Истина; 		
	Иначе           		
		Список.Отбор.Элементы[5].Использование  = Ложь;      		
	КонецЕсли;  
	
КонецПроцедуры


#КонецОбласти

//======================================================================================================================

#Область ОБРАБОТЧИКИ_КОМАНД_С_Кодами

&НаКлиенте
Процедура СоздатьПротокол(Команда)
	
	ТД = Элементы.Список.ТекущиеДанные; 
	
	Если  ТД <> Неопределено  Тогда
		
		Если  ЗначениеЗаполнено(ТД.Протокол)   Тогда
					
			ТекстПредупреждения =  "На направление № " + ТД.НомерНаправления + " выписан протокол №" + СтрЗаменить(Строка(ТД.Протокол), "Протокол","");
			ПоказатьПредупреждение(,ТекстПредупреждения,,"Внимание!" );
			
		Иначе
			
			Ответ = ВсеИсследванияСДаннымКодомВыполнены( ТД.КодПробы, ТД.ОбщееНаправление) ;			
			Если Не ЗначениеЗаполнено(Ответ) Тогда
				
			   ПараметрыФормы = Новый Структура;
			   ПараметрыФормы.Вставить("КодПробы",           ТД.КодПробы); 		
			   ПараметрыФормы.Вставить("НомерНаправления",   ТД.НомерНаправления); 
			   ПараметрыФормы.Вставить("ОбщееНаправление",   ТД.ОбщееНаправление); 
			   
			   ОткрытьФорму("Документ._ИМЦ_ЕдиныйПротокол.Форма.ФормаДокумента",ПараметрыФормы,);   
		   Иначе
			   
			   ДополнительныеПараметры = Новый Структура("КодПробы, НомерНаправления, ОбщееНаправление", ТД.КодПробы, ТД.НомерНаправления, ТД.ОбщееНаправление);
			   
			   ОписаниеОповещения = Новый ОписаниеОповещения("ПослеЗавершенияВопросаОСозданииПротокола", ЭтаФорма, ДополнительныеПараметры);       			   
			   ПоказатьВопрос(ОписаниеОповещения,
			   				"Не выполненны исследования проб: " + Ответ + ". Создать проткол?",
							РежимДиалогаВопрос.ДаНет,
							,
							КодВозвратаДиалога.Нет,
							"Внимание!");   		    
			  			   
			КонецЕсли;	
			
		КонецЕсли;   		
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПросмотретьРезультаты(Команда)
	
	ТД = Элементы.Список.ТекущиеДанные; 
	
	Если  ТД <> Неопределено  Тогда
		       			
		Если  ЗначениеЗаполнено(ТД.ДатаВыдачиРезультата)   Тогда
						
			ПараметрыФормы = Новый Структура;
			ПараметрыФормы.Вставить("КодПробы", ТД.КодПробы); 		
			ПараметрыФормы.Вставить("НомерНаправления", ТД.НомерНаправления);  
			ПараметрыФормы.Вставить("ОбщееНаправление", ТД.ОбщееНаправление);
			
			ОткрытьФормуМодально("Обработка._ИМЦ_СписокПроб.Форма.ФормаРезультатыИсследованияПробы",ПараметрыФормы,);  
			
		КонецЕсли;					
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВозвратРезультатовЛабораторию(Команда)
	
	
	ТД = Элементы.Список.ТекущиеДанные; 
	
	Если  ТД <> Неопределено  Тогда
		
		КомментарийКВозврату = "";
		ВвестиСтроку(КомментарийКВозврату , "Кратко опишите причину возврата!", 150 ,Истина); 
		
		Если  ЗначениеЗаполнено(ТД.ДатаВыдачиРезультата)   Тогда
			
			ВозвратРезультатовЛабораториюНаСервере(ТД.НомерНаправления, ТД.КодПробы, ТД.ОбщееНаправление, КомментарийКВозврату);  
			
		КонецЕсли;					
		
	КонецЕсли;   
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьТЗ_БезКода(Команда)
	ОбновитьТЗ_БезКодаНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура СоздатьПротокол2(Команда)
	
	ВыделенныеСтроки = Элементы.ТЗ.ВыделенныеСтроки;
	ТекстПредупреждения = "";
	МасСтруктур = Новый Массив;
	Для Каждого ВыдСтрока Из ВыделенныеСтроки Цикл
		
		НайдСтрока = ТЗ.НайтиПоИдентификатору(ВыдСтрока);
		Если НайдСтрока <> Неопределено Тогда  			
			Если ЗначениеЗаполнено(НайдСтрока.Протокол) Тогда
				ТекстПредупреждения = ?(ЗначениеЗаполнено(ТекстПредупреждения),
					ТекстПредупреждения +"
					|" + "На направление № " + НайдСтрока.НомерНаправления + " выписан протокол №" + СтрЗаменить(Строка(НайдСтрока.Протокол), "Протокол",""),
					"На направление № " + НайдСтрока.НомерНаправления + " выписан протокол №" + СтрЗаменить(Строка(НайдСтрока.Протокол), "Протокол",""));
			Иначе
				МасСтруктур.Добавить(Новый Структура("НомерНаправления, КодПробы, Исследование",НайдСтрока.НомерНаправления, , НайдСтрока.Исследование));
			КонецЕсли;                                                            
			
		Иначе
			ПоказатьПредупреждение(,"Ошибка. Не найдена строка! Обратитесь к администаратору системы!",,"Внимание!" );					
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ТекстПредупреждения) Тогда
			ПоказатьПредупреждение(,ТекстПредупреждения,,"Внимание!");
		Иначе
			ПараметрыФормы	= Новый Структура;
			ПараметрыФормы.Вставить("Заявитель",          НайдСтрока.Заявитель); 		
			ПараметрыФормы.Вставить("Заявление",          НайдСтрока.ЗаявкаНаИсследование); 
			ПараметрыФормы.Вставить("Исследования",       МасСтруктур); 
			ПараметрыФормы.Вставить("ОбщееНаправление",   НайдСтрока.ОбщееНаправление); 
			
			ОткрытьФорму("Документ._ИМЦ_ЕдиныйПротокол.Форма.ФормаДокумента",ПараметрыФормы,);

		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

//======================================================================================================================

#Область СЛУЖЕБНЫЕ_ПРОЦЕДУРЫ_И_ФУНКЦИИ_С_Кодамами

&НаСервере
Функция ПолучитьПользователя()
	
	Возврат ПараметрыСеанса.ТекущийПользователь;
	
КонецФункции

&НаСервере
Процедура ВозвратРезультатовЛабораториюНаСервере(НомерНаправления, КодПробы, ОбщееНаправление, Комментарий)
	
	запрос = Новый Запрос;
	запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	               |	_ИМЦ_РезультатыИсследований.Регистратор
	               |ИЗ
	               |	РегистрСведений._ИМЦ_РезультатыИсследований КАК _ИМЦ_РезультатыИсследований
	               |ГДЕ
	               |	_ИМЦ_РезультатыИсследований.ОбщееНаправление = &ОбщееНаправление
	               |	И _ИМЦ_РезультатыИсследований.НомерНаправления = &НомерНаправления";
	
	запрос.УстановитьПараметр("НомерНаправления", НомерНаправления);
	запрос.УстановитьПараметр("ОбщееНаправление", ОбщееНаправление);
	
	Результат =  запрос.Выполнить().Выгрузить();
	
	
	//отмена проведения и изменение статуса
	
	Если  Результат.Количество()   Тогда
		
	   ДокОбъект = Результат[0].Регистратор.ПолучитьОбъект();  
	   ДокОбъект.Записать(РежимЗаписиДокумента.ОтменаПроведения);
	   
	   //отправка сообщений пользователям
	   Если ЗначениеЗаполнено(ДокОбъект.Лаборатория) Тогда
		   
		   ПользователиЛаборатории = Новый Запрос;
		   ПользователиЛаборатории.Текст = "ВЫБРАТЬ
		                                   |	Пользователи.Ссылка КАК Пользователь
		                                   |ИЗ
		                                   |	Справочник.Пользователи КАК Пользователи
		                                   |ГДЕ
		                                   |	Пользователи.Лаборатория = &Лаборатория";
		   
		   ПользователиЛаборатории.УстановитьПараметр("Лаборатория", ДокОбъект.Лаборатория);
		   
		   ТЗ_Пользователи =  ПользователиЛаборатории.Выполнить().Выгрузить();
		   
		   
		   Для каждого Стр Из ТЗ_Пользователи Цикл     			   
			   
			   НовыйГУИД = Новый УникальныйИдентификатор();  			   
			   НаборЗаписей = РегистрыСведений._ИМЦ_РегистрСообщенийПользователям.СоздатьНаборЗаписей();  			   
			   НаборЗаписей.Отбор.Пользователь.Установить(Стр.Пользователь); 		
			   НаборЗаписей.Отбор.ГУИД.Установить(НовыйГУИД);
			   //НаборЗаписей.Очистить();
			   
			   Запись = НаборЗаписей.Добавить(); 
			   
			   Запись.ТекстСообщения  = "Исследование с номером направления: " + НомерНаправления + " и кодом пробы " 
			                             + КодПробы + " ВОЗВРАЩЕНО, пользователем " + ПараметрыСеанса.ТекущийПользователь  + "
										  |" + "Комментарий: " + Комментарий; 
										 
			   Запись.Пользователь    = Стр.Пользователь; 		   
			   Запись.ДатаОповещения  = ТекущаяДата(); 
			   Запись.Прочитано       = Ложь;			    
			   Запись.Ссылка          = Результат[0].Регистратор;
			   Запись.ГУИД            = НовыйГУИД;
			   
			   НаборЗаписей.Записать(); 
			   
		   КонецЦикла;    		
		   
	   КонецЕсли;
	  	   
	   
	   
	КонецЕсли;	
	
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция  ВсеИсследванияСДаннымКодомВыполнены(Знач КодПробы, ОбщееНаправление)
	
	//для того чтобы проверить выполненные результаты по всем лабораториям, для кода типа 111.2.30.12.11.В   
	// где 111 - порядковый номер
	// 2 - код лаборатори
	// 30.12.11 - дата
	// В - тип финансирования			
	
	
	ПорядковаяЧастьКода = Сред(КодПробы,1 ,Найти(КодПробы,".")); // получаем порядковый номер 
	
	КодПробы = СтрЗаменить(КодПробы,ПорядковаяЧастьКода,"");
	
	ОставшаясьЧастьКода = Сред(КодПробы, Найти(КодПробы,".")); //получаем всё после лаборатории
	
	КодПробы =  ПорядковаяЧастьКода + "%" + ОставшаясьЧастьКода;
	
	
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.КодПробы
	               |ПОМЕСТИТЬ ВТ
	               |ИЗ
	               |	Документ._ИМЦ_ОбщееНаправление.ИсследованияПоЛабораториям КАК _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям
	               |ГДЕ
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка = &Ссылка
	               |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.КодПробы ПОДОБНО &КодПробы
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.КодПробы
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ВТ.КодПробы,
	               |	ВЫБОР
	               |		КОГДА ИСТИНА В
	               |				(ВЫБРАТЬ ПЕРВЫЕ 1
	               |					ИСТИНА
	               |				ИЗ
	               |					РегистрСведений._ИМЦ_РезультатыИсследований КАК РС
	               |				ГДЕ
	               |					РС.КодКонтрагента = ВТ.КодПробы)
	               |			ТОГДА 1
	               |		ИНАЧЕ 0
	               |	КОНЕЦ КАК ИсследованиеВыполненно
	               |ИЗ
	               |	ВТ КАК ВТ
	               |ГДЕ
	               |	ВЫБОР
	               |		КОГДА ИСТИНА В
	               |				(ВЫБРАТЬ ПЕРВЫЕ 1
	               |					ИСТИНА
	               |				ИЗ
	               |					РегистрСведений._ИМЦ_РезультатыИсследований КАК РС
	               |				ГДЕ
	               |					РС.КодКонтрагента = ВТ.КодПробы)
	               |			ТОГДА 1
	               |		ИНАЧЕ 0
	               |	КОНЕЦ = 0";
	
	Запрос.УстановитьПараметр("Ссылка",      ОбщееНаправление);
	Запрос.УстановитьПараметр("КодПробы",    КодПробы);
	
	Результат = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("КодПробы");	
	Если Результат.Количество() Тогда		
		Текст = "";
		Для Каждого ЭлМас Из Результат Цикл      			
			Текст = Текст + " " + ЭлМас;         			
		КонецЦикла;
		
		Возврат Текст;
	Иначе
		Возврат "";		
	КонецЕсли; 

КонецФункции

&НаКлиенте
Процедура ПослеЗавершенияВопросаОСозданииПротокола(ОтветНаВопрос, ДополнительныеПараметры) Экспорт
	
	Если ОтветНаВопрос = КодВозвратаДиалога.Да Тогда
		
		ОткрытьФорму("Документ._ИМЦ_ЕдиныйПротокол.Форма.ФормаДокумента",ДополнительныеПараметры,);		
	КонецЕсли; 
	
КонецПроцедуры

Процедура УстановкаПараметровДинамическогоСписка()
	
КонецПроцедуры



#КонецОбласти


#КонецОбласти

#Область БезКода

#Область ОБРАБОТЧИКИ_СОБЫТИЙ_ЭЛЕМЕНТОВ_ФОРМЫ_БезКода

&НаКлиенте
Процедура Мои1ПриИзменении(Элемент)
	ОбновитьТЗ_БезКодаНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура НеОтображатьСПротоколами1ПриИзменении(Элемент)
	ОбновитьТЗ_БезКодаНаСервере();
КонецПроцедуры     

#КонецОбласти

//======================================================================================================================

#Область ОБРАБОТЧИКИ_СОБЫТИЙ_ЭЛЕМЕНТОВ_ФОРМЫ_БезКода

&НаКлиенте
Процедура ПериодДляТЗ_БезКодаПриИзменении(Элемент)
	ОбновитьТЗ_БезКодаНаСервере();
КонецПроцедуры

#КонецОбласти

//======================================================================================================================
#Область СЛУЖЕБНЫЕ_ПРОЦЕДУРЫ_И_ФУНКЦИИ_БезКода

&НаСервере
Процедура ОбновитьТЗ_БезКодаНаСервере()
	
	Запрос = Новый Запрос();
	Запрос.Текст = "ВЫБРАТЬ
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка КАК ОбщееНаправление,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.НомерНаправления,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Лаборатория,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка._ИМЦ_Организация,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Ответственный,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Подразделение,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.ДатаОтправленияВЛабораторию,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.ЗаявкаНаИсследование КАК ЗаявкаНаИсследование
	               |ПОМЕСТИТЬ ВТ_ОбщееНаправление
	               |ИЗ
	               |	Документ._ИМЦ_ОбщееНаправление.ИсследованияПоЛабораториям КАК _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям
	               |ГДЕ
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.НомерНаправления <> """"
	               |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.КодПробы = """"
	               |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.ДатаОтправленияВЛабораторию <> ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
	               |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Подразделение = &Подразделение
	               |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Ответственный = &Ответственный
	               |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка._ИМЦ_Организация = &_ИМЦ_Организация
	               |	И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Дата > &ДатаПолГода
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Лаборатория,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.НомерНаправления,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка._ИМЦ_Организация,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Ответственный,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Подразделение,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.ДатаОтправленияВЛабораторию,
	               |	_ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.ЗаявкаНаИсследование
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ВТ_ОбщееНаправление.ОбщееНаправление,
	               |	ВТ_ОбщееНаправление._ИМЦ_Организация,
	               |	ВТ_ОбщееНаправление.Ответственный,
	               |	ВТ_ОбщееНаправление.Подразделение,
	               |	_ИМЦ_РезультатыИсследований.Регистратор КАК Исследование,
	               |	_ИМЦ_РезультатыИсследований.ДатаВыдачиРезультата,
	               |	_ИМЦ_РезультатыИсследований.Лаборатория,
	               |	ВТ_ОбщееНаправление.НомерНаправления,
	               |	ВТ_ОбщееНаправление.ЗаявкаНаИсследование,
	               |	ВТ_ОбщееНаправление.ДатаОтправленияВЛабораторию
	               |ПОМЕСТИТЬ ВТ_Исследования
	               |ИЗ
	               |	ВТ_ОбщееНаправление КАК ВТ_ОбщееНаправление
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений._ИМЦ_РезультатыИсследований КАК _ИМЦ_РезультатыИсследований
	               |		ПО ВТ_ОбщееНаправление.ОбщееНаправление = _ИМЦ_РезультатыИсследований.ОбщееНаправление
	               |			И ВТ_ОбщееНаправление.НомерНаправления = _ИМЦ_РезультатыИсследований.НомерНаправления
	               |			И ВТ_ОбщееНаправление.Лаборатория = _ИМЦ_РезультатыИсследований.Лаборатория
	               |ГДЕ
	               |	_ИМЦ_РезультатыИсследований.ДатаВыдачиРезультата >= НАЧАЛОПЕРИОДА(&ДатаВыдачиРезультатаН, ДЕНЬ)
	               |	И _ИМЦ_РезультатыИсследований.ДатаВыдачиРезультата <= КОНЕЦПЕРИОДА(&ДатаВыдачиРезультатаК, ДЕНЬ)
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	_ИМЦ_РезультатыИсследований.ДатаВыдачиРезультата,
	               |	ВТ_ОбщееНаправление._ИМЦ_Организация,
	               |	_ИМЦ_РезультатыИсследований.Лаборатория,
	               |	_ИМЦ_РезультатыИсследований.Регистратор,
	               |	ВТ_ОбщееНаправление.ЗаявкаНаИсследование,
	               |	ВТ_ОбщееНаправление.ДатаОтправленияВЛабораторию,
	               |	ВТ_ОбщееНаправление.Ответственный,
	               |	ВТ_ОбщееНаправление.Подразделение,
	               |	ВТ_ОбщееНаправление.НомерНаправления,
	               |	ВТ_ОбщееНаправление.ОбщееНаправление
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ВТ_Исследования.ОбщееНаправление,
	               |	ВТ_Исследования._ИМЦ_Организация,
	               |	ВТ_Исследования.Ответственный,
	               |	ВТ_Исследования.Подразделение,
	               |	ВТ_Исследования.Лаборатория,
	               |	ВТ_Исследования.НомерНаправления,
	               |	ВТ_Исследования.ДатаОтправленияВЛабораторию,
	               |	ВТ_Исследования.ДатаВыдачиРезультата,
	               |	ВТ_Исследования.ЗаявкаНаИсследование,
	               |	_ИМЦ_Связь_Протокол_КодПробы_НомерНаправления.Регистратор.Ссылка КАК Протокол,
	               |	ВТ_Исследования.Исследование
	               |ПОМЕСТИТЬ ВТ_Исследования_БезПротокола
	               |ИЗ
	               |	ВТ_Исследования КАК ВТ_Исследования
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений._ИМЦ_Связь_Протокол_КодПробы_НомерНаправления КАК _ИМЦ_Связь_Протокол_КодПробы_НомерНаправления
	               |		ПО ВТ_Исследования.Исследование = _ИМЦ_Связь_Протокол_КодПробы_НомерНаправления.Исследование";
	
	
	Если ЗначениеЗаполнено(Подразделение) Тогда
		Запрос.УстановитьПараметр("Подразделение", Подразделение);
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Подразделение = &Подразделение", "")
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Организация) Тогда
		Запрос.УстановитьПараметр("_ИМЦ_Организация", Организация);
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка._ИМЦ_Организация = &Организация", "")
	КонецЕсли;
			
	Если Мои Тогда
		Запрос.УстановитьПараметр("Ответственный", ПараметрыСеанса.ТекущийПользователь);
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"И _ИМЦ_ОбщееНаправлениеИсследованияПоЛабораториям.Ссылка.Ответственный = &Ответственный", "")
	КонецЕсли;
	
	Если НеОтображатьСПротоколами Тогда
		
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "  
												|	УПОРЯДОЧИТЬ ПО
	 			   								|	НомерНаправления", "");
		
		Запрос.Текст =  Запрос.Текст + " 
							|;
							|
							|////////////////////////////////////////////////////////////////////////////////
							|ВЫБРАТЬ
							|	ВТ_Исследования_БезПротокола.ОбщееНаправление,
							|	ВТ_Исследования_БезПротокола._ИМЦ_Организация,
							|	ВТ_Исследования_БезПротокола.Ответственный,
							|	ВТ_Исследования_БезПротокола.Подразделение,
							|	ВТ_Исследования_БезПротокола.Лаборатория,
							|	ВТ_Исследования_БезПротокола.НомерНаправления,
							|	ВТ_Исследования_БезПротокола.ДатаОтправленияВЛабораторию,
							|	ВТ_Исследования_БезПротокола.ДатаВыдачиРезультата,
							|	ВТ_Исследования_БезПротокола.ЗаявкаНаИсследование,
							|	ВТ_Исследования_БезПротокола.Протокол,
							|	ВТ_Исследования_БезПротокола.Исследование
							|ИЗ
							|	ВТ_Исследования_БезПротокола КАК ВТ_Исследования_БезПротокола
							|ГДЕ
							|	ВТ_Исследования_БезПротокола.Протокол  Есть null Или
							|	(ВЫРАЗИТЬ(ВТ_Исследования_БезПротокола.Протокол КАК Документ._ИМЦ_ЕдиныйПротокол)) = ЗНАЧЕНИЕ(Документ._ИМЦ_ЕдиныйПротокол.ПустаяСсылка)
							|	 
	 						|УПОРЯДОЧИТЬ ПО
	 						|	НомерНаправления";
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ПОМЕСТИТЬ ВТ_Исследования_БезПротокола", "");					
	КонецЕсли;
	
	Запрос.УстановитьПараметр("ДатаВыдачиРезультатаН", ПериодДляТЗ_БезКода.ДатаНачала);
	Запрос.УстановитьПараметр("ДатаВыдачиРезультатаК", ПериодДляТЗ_БезКода.ДатаОкончания);
	Запрос.УстановитьПараметр("ДатаПолГода", ДобавитьМесяц(ТекущаяДата(),-6));

	Результат = Запрос.Выполнить().Выгрузить();

	ТЗ.Очистить();
	Для Каждого Стр Из Результат  Цикл
		
		НСТР = ТЗ.Добавить();
		ЗаполнитьЗначенияСвойств(НСТР, Стр);
		НСТР.ОбъектыИсследования = Стр.Исследование.ОбъектыИсследования;
		Если ЗначениеЗаполнено(Стр.ЗаявкаНаИсследование) Тогда
			Если ТипЗнч(Стр.ЗаявкаНаИсследование) = Тип("ДокументСсылка._ИМЦ_ЗаявкаБюджет") Тогда
				НСТР.Заявитель = Стр.ЗаявкаНаИсследование.Роспотребнадзор;
			Иначе
				НСТР.Заявитель = Стр.ЗаявкаНаИсследование.Контрагент;
			КонецЕсли;
		КонецЕсли;
				                  
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти