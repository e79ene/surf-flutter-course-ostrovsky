abstract class HistoryAction {}

class HistoryClearAction implements HistoryAction {}

class HistoryRemoveAction implements HistoryAction {
  final String string;

  const HistoryRemoveAction(this.string);
}

class HistoryAddAction implements HistoryAction {
  final String string;

  const HistoryAddAction(this.string);
}
