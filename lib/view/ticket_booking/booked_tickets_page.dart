import 'package:evento_event_booking/blocs/ticket_booking/bloc/ticket_booking_bloc.dart';
import 'package:evento_event_booking/widgets/booked_tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BookedTicketsPage extends StatefulWidget {
  const BookedTicketsPage({Key? key}) : super(key: key);

  @override
  State<BookedTicketsPage> createState() => _BookedTicketsPageState();
}

class _BookedTicketsPageState extends State<BookedTicketsPage> {
  late TicketBookingBloc _ticketBookingBloc;

  @override
  void initState() {
    super.initState();
    // Initialize the BLoC and trigger the event to fetch booked tickets
    _ticketBookingBloc = TicketBookingBloc();
    _ticketBookingBloc.add(GetBookedTickets());
  }

  @override
  void dispose() {
    // Dispose of the BLoC when the page is closed to avoid memory leaks
    _ticketBookingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Tickets'),
      ),
      body: BlocProvider(
        create: (_) => _ticketBookingBloc,
        child: BlocBuilder<TicketBookingBloc, TicketBookingState>(
          builder: (context, state) {
            if (state is BookedTicketsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorFetchingBookedTickets) {
              return Center(
                child: Text(
                  'Error: ${state.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is BookedTicketsFetched) {
              if (state.bookedTickets.isEmpty) {
                return const Center(child: Text('No booked tickets found.'));
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: state.bookedTickets.length,
                itemBuilder: (context, index) {
                  final ticket = state.bookedTickets[index];
                  return BookedTickets(bookedTicketModel: ticket,); // Your widget for showing tickets
                },
              );
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }
}

