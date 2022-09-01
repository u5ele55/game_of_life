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

  bool showField = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FieldBloc, FieldState>(
        listener: (context, state) {
          if (state.status != FieldStatus.initial) {
            setState(() => showField = true);
          }
        },
        listenWhen: (previous, current) => previous.status != current.status,
        child: showField
            ? Stack(
                children: [
                  my.Zoom(
                      opacityScrollBars: 0,
                      maxZoomWidth: constants.cellSize * constants.fieldWidth,
                      maxZoomHeight: constants.cellSize * constants.fieldHeight,
                      doubleTapZoom: false,
                      onPointTap: (details) {
                        context.read<FieldBloc>().add(TapCellEvent(
                            Position.fromOffset(
                                details ~/ constants.cellSize)));
                      },
                      child: SizedBox(
                        height: constants.fieldHeight * constants.cellSize,
                        width: constants.fieldWidth * constants.cellSize,
                        child: BlocBuilder<FieldBloc, FieldState>(
                          builder: (_, state) {
                            return CustomPaint(
                              foregroundPainter: FieldPainter(),
                              painter: CellPainter(state.field),
                            );
                          },
                        ),
                      )),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        BlocBuilder<FieldBloc, FieldState>(
                          builder: (_, state) => IconButton(
                            icon: state.status == FieldStatus.playing
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow),
                            onPressed: () => context
                                .read<FieldBloc>()
                                .add(ToggleStatusEvent()),
                            iconSize: 64,
                          ),
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
              )
            : const Center(child: CircularProgressIndicator.adaptive()));
  }
}
