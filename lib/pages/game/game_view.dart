part of 'game_page.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(constants.updateDuration,
        (Timer t) => context.read<FieldBloc>().add(UpdateFieldEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldBloc, FieldState>(
      builder: (context, state) {
        if (state.status == FieldStatus.initial) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return Stack(
          children: [
            Zoom(
              maxZoomWidth: constants.cellSize * constants.fieldWidth,
              maxZoomHeight: constants.cellSize * constants.fieldHeight,
              doubleTapZoom: false,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                    children: (state.field.field ?? [])
                        .map((list) => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              child: Row(
                                children: list
                                    .map((cell) => CellWidget(cell: cell))
                                    .toList(),
                              ),
                            ))
                        .toList()),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  IconButton(
                    icon: state.status == FieldStatus.playing
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow),
                    onPressed: () =>
                        context.read<FieldBloc>().add(ToggleStatusEvent()),
                    iconSize: 64,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () =>
                        context.read<FieldBloc>().add(InitFieldEvent()),
                    iconSize: 64,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
