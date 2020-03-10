#ifndef MULTIMEDIA_H
#define MULTIMEDIA_H

#include <QtQuick>
#include <sailfishapp.h>
#include <QAudioRecorder>

class AudioRecorder : public QAudioRecorder
{
    Q_OBJECT
public:
    AudioRecorder() {
        QAudioEncoderSettings audioSettings;
        audioSettings.setCodec("audio/PCM");
        audioSettings.setQuality(QMultimedia::HighQuality);
        this->setEncodingSettings(audioSettings);
        this->setContainerFormat("wav");
    }
    virtual ~AudioRecorder() {}
};


#endif // MULTIMEDIA_H
