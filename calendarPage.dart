import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'toDoListPage.dart';


class CalendarPage extends StatefulWidget {
	@override
	CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
	late CalendarFormat calendarController;
	DateTime focusedDay = DateTime.now();
	late DateTime selectedDay;

	@override
	void initState() {  
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		// Scaffold principal com AppBar laranja forte
		return Scaffold(
			appBar: AppBar(
				title: Text('Calendário'),
				backgroundColor: Colors.deepOrange, // cor da barra superior
				foregroundColor: Colors.white, // cor do texto
			
			),
			body: Container(
				color: Colors.orange[50], // cor de fundo suave
				child: SingleChildScrollView(
					child: Padding(
						padding: const EdgeInsets.all(16.0), // espaçamento geral
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.center,
							children: <Widget>[
								// Título de boas-vindas
								Text(
									'Bem-vindo, Henrique!',
									style: TextStyle(
										fontSize: 28,
										fontWeight: FontWeight.bold,
										color: Colors.deepOrange,
									),
									textAlign: TextAlign.center,
								),
								SizedBox(height: 8),
								// Data do dia
								Text(
									'Dia ${focusedDay.day}/${focusedDay.month}/${focusedDay.year}',
									style: TextStyle(
										fontSize: 18,
										color: Colors.deepOrange,
									),
									textAlign: TextAlign.center,
								),
								SizedBox(height: 24),
								// Calendário 
								Container(
									decoration: BoxDecoration(
										color: Colors.white,
										borderRadius: BorderRadius.circular(16),
										boxShadow: [
											BoxShadow(
												color: Colors.deepOrange.withOpacity(0.1),
												blurRadius: 8,
												offset: Offset(0, 4),
											),
										],
									),
									child: TableCalendar(
										calendarFormat: CalendarFormat.month,
										focusedDay: focusedDay,
										firstDay: DateTime(2000),
										lastDay: DateTime(2050),
										onFormatChanged: (format) {
											setState(() {
												calendarController = format;
											});
										},
										onDaySelected: (selectedDay, focusedDay) {
											Navigator.push(
												context,
												MaterialPageRoute(
													builder: (context) => ToDoListPage(selectedDate: selectedDay),
												),
											);
										},
										headerStyle: HeaderStyle(
											formatButtonVisible: false,
											titleCentered: true,
											decoration: BoxDecoration(
												color: Colors.deepOrange,
												borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
											),
											titleTextStyle: TextStyle(
												color: Colors.white,
												fontWeight: FontWeight.bold,
												fontSize: 20,
											),
										),
										daysOfWeekStyle: DaysOfWeekStyle(
											weekendStyle: TextStyle(color: Colors.deepOrange),
											weekdayStyle: TextStyle(color: Colors.deepOrange),
										),
										calendarStyle: CalendarStyle(
											todayDecoration: BoxDecoration(
												color: Colors.orange,
												shape: BoxShape.circle,
											),
											selectedDecoration: BoxDecoration(
												color: Colors.deepOrange,
												shape: BoxShape.circle,
											),
											weekendTextStyle: TextStyle(color: Colors.deepOrange),
											defaultTextStyle: TextStyle(color: Colors.deepOrange),
										),
									),
								),
							],
						),
					),
				),
			),
		);
	}
}
