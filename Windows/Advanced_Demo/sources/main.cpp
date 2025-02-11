﻿#include "RoomMainWidget.h"
#include <QtWidgets/QApplication>
#include <QScreen>

int main(int argc, char *argv[]) {
    qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", "1");

    QApplication a(argc, argv);
    a.setQuitOnLastWindowClosed(true);
    a.setWindowIcon(QIcon(":/QuickStart/app.ico"));
    RoomMainWidget w;
    w.show();

    auto desktopWidget = QApplication::primaryScreen();
    auto screenGem = desktopWidget->availableGeometry();
    int width = screenGem.width() * 0.8;
    int height = width * 9.0 / 16;

    QRect selfGem = QRect(0, 0, width, height);
    selfGem.moveCenter(screenGem.center());
    w.setGeometry(selfGem);

    return a.exec();
}
