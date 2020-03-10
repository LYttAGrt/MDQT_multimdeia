#include <QtQuick>
#include <sailfishapp.h>
#include "multimedia.h"

int main(int argc, char *argv[])
{
    // ToDo: register AudioRecorder class in QML-module Multimedia
    qmlRegisterType<AudioRecorder>("Multimedia", 1, 0, "AudioRecorder");
    return SailfishApp::main(argc, argv);
}
