import 'package:clean/features/numbertrivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean/features/numbertrivia/presentation/widgets/widgets.dart';
import 'package:clean/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
        ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start Searching!',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                  return MessageDisplay(message: 'Unknown Error occured');
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}


