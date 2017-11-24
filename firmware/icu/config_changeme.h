#ifndef _CONFIG_H
#define _CONFIG_H

#define DEBUG_MODE
#define LED_COUNT    8
#define LED_PIN     D2
#define BUTTON_PIN  D1
#define BUTTONLOW_PIN D0
#define SERVO_PIN D7

#define FADEIN_DELAY 5
#define FADEOUT_DELAY 8


#define REQUEST_DELAY 1000

// Change project name
#define PROJECT_SHORT_NAME "iCu"
// Change server name
#define SERVER_URL "http://your.iCu.server/"
// Change default SSID
#define CONFIG_SSID "iCu"
// Change default SSID and password
#define BACKUP_SSID "BackupSSIDName"
#define BACKUP_PASSWORD "BackupPassword"

// Change firmware version
#define FIRMWARE_VERSION 1
// Change firmware update address
#define FIRMWARE_URL "http://your.firmware.update.server/"

#endif
