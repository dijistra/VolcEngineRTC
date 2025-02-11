﻿#pragma once

#include <QtWidgets/QMainWindow>
#include "ui_OperateWidget.h"

class OperateWidget : public QWidget {
    Q_OBJECT

public:
    OperateWidget(QWidget *parent = Q_NULLPTR);
	void reset();
protected:
    bool eventFilter(QObject *watched, QEvent *event) override;

    void paintEvent(QPaintEvent *event) override;

private
    slots:
            void on_hangupBtn_clicked();

    void on_muteAudioBtn_clicked();

    void on_muteVideoBtn_clicked();

    signals:
            void sigHangup();

    void sigMuteVideo(bool);

    void sigMuteAudio(bool);

private:
    Ui::OperateForm ui;
};
