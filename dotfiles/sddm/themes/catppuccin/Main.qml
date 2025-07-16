import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

Rectangle {
    id: root
    
    // Configuración del tema
    property color primaryColor: "#cba6f7"      // Catppuccin purple
    property color secondaryColor: "#f5c2e7"    // Catppuccin pink
    property color accentColor: "#f9e2af"       // Catppuccin yellow
    property color textColor: "#cdd6f4"         // Catppuccin text
    property color backgroundColor: "#1e1e2e"    // Catppuccin base
    property color surfaceColor: "#313244"      // Catppuccin surface0
    
    // Dimensiones
    width: 1920
    height: 1080
    
    // Fondo con imagen dinámica
    Rectangle {
        id: background
        anchors.fill: parent
        
        // Imagen de fondo dinámica
        Image {
            id: backgroundImage
            anchors.fill: parent
            source: "file:///home/" + Qt.getenv("USER") + "/Pictures/wallpapers/sddm-background.jpg"
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            
            // Fallback si la imagen no existe
            onStatusChanged: {
                if (status === Image.Error) {
                    console.log("Background image not found, using gradient fallback")
                    background.gradient = fallbackGradient
                }
            }
        }
        
        // Overlay para mejorar legibilidad
        Rectangle {
            anchors.fill: parent
            color: "#1e1e2e"
            opacity: 0.7
        }
        
        // Gradiente de fallback
        gradient: Gradient {
            id: fallbackGradient
            GradientStop { position: 0.0; color: "#1e1e2e" }
            GradientStop { position: 0.5; color: "#313244" }
            GradientStop { position: 1.0; color: "#1e1e2e" }
        }
    }
    
    // Contenido principal
    Rectangle {
        id: mainContainer
        anchors.centerIn: parent
        width: 400
        height: 500
        color: surfaceColor
        radius: 20
        opacity: 0.95
        
        // Efecto de sombra
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 10
            radius: 20
            samples: 20
            color: "#000000"
            opacity: 0.3
        }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 30
            spacing: 20
            
            // Logo o título
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "transparent"
                
                Text {
                    anchors.centerIn: parent
                    text: "Arch Linux"
                    font.pixelSize: 32
                    font.weight: Font.Bold
                    color: primaryColor
                }
            }
            
            // Separador
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 2
                color: primaryColor
                opacity: 0.5
            }
            
            // Campo de usuario
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: backgroundColor
                radius: 10
                
                TextInput {
                    id: userInput
                    anchors.fill: parent
                    anchors.margins: 15
                    font.pixelSize: 16
                    color: textColor
                    verticalAlignment: TextInput.AlignVCenter
                    focus: true
                    
                    // Placeholder
                    Text {
                        anchors.fill: parent
                        text: "Usuario"
                        color: textColor
                        opacity: 0.6
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignVCenter
                        visible: !userInput.text
                    }
                }
            }
            
            // Campo de contraseña
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: backgroundColor
                radius: 10
                
                TextInput {
                    id: passwordInput
                    anchors.fill: parent
                    anchors.margins: 15
                    font.pixelSize: 16
                    color: textColor
                    verticalAlignment: TextInput.AlignVCenter
                    echoMode: TextInput.Password
                    
                    // Placeholder
                    Text {
                        anchors.fill: parent
                        text: "Contraseña"
                        color: textColor
                        opacity: 0.6
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignVCenter
                        visible: !passwordInput.text
                    }
                }
            }
            
            // Botón de login
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: primaryColor
                radius: 10
                
                Text {
                    anchors.centerIn: parent
                    text: "Iniciar Sesión"
                    font.pixelSize: 16
                    font.weight: Font.Bold
                    color: backgroundColor
                }
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // Aquí iría la lógica de login
                        console.log("Login attempt for user:", userInput.text)
                    }
                }
            }
            
            // Información del sistema
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: "transparent"
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 5
                    
                    Text {
                        Layout.fillWidth: true
                        text: "Sistema: Arch Linux"
                        font.pixelSize: 12
                        color: textColor
                        opacity: 0.8
                        horizontalAlignment: Text.AlignHCenter
                    }
                    
                    Text {
                        Layout.fillWidth: true
                        text: "Tema: Catppuccin"
                        font.pixelSize: 12
                        color: textColor
                        opacity: 0.8
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
    }
    
    // Indicador de carga
    Rectangle {
        id: loadingIndicator
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        width: 200
        height: 4
        color: surfaceColor
        radius: 2
        
        Rectangle {
            id: loadingBar
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width * 0.3
            color: primaryColor
            radius: 2
            
            SequentialAnimation on width {
                loops: Animation.Infinite
                NumberAnimation { to: parent.width * 0.7; duration: 1000 }
                NumberAnimation { to: parent.width * 0.3; duration: 1000 }
            }
        }
    }
    
    // Animación de entrada
    Component.onCompleted: {
        mainContainer.scale = 0.8
        mainContainer.opacity = 0
        
        mainContainer.scale = 1.0
        mainContainer.opacity = 0.95
    }
} 