cmake_minimum_required(VERSION 3.16)

project(NDS_SpriteExporter VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appNDS_SpriteExporter
    main.cpp
)

qt_add_qml_module(appNDS_SpriteExporter
    URI NDS_SpriteExporter
    QML_FILES
        Main.qml
        SOURCES backend.h backend.cpp
        SOURCES AppConstants.h
        SOURCES AppConstants.h
        QML_FILES QmlComponents/ScalableButton.qml QmlComponents/SquareImageContainer.qml QmlComponents/StatusOverlay.qml
        QML_FILES QmlComponents/NeutralContainer.qml
        QML_FILES QmlComponents/CustomDropArea.qml
        QML_FILES QmlComponents/Spacer.qml
        QML_FILES QmlComponents/CustomColLay.qml
        QML_FILES QmlComponents/CustomRowLay.qml
        QML_FILES QmlComponents/FilePickerButton.qml
        QML_FILES QmlComponents/ScalableTextField.qml
        QML_FILES QmlComponents/LabeledScalableTextField.qml
        QML_FILES QmlComponents/FolderPicker.qml
        QML_FILES QmlComponents/ScalableSlider.qml
        QML_FILES QmlComponents/LabeledScalableSlider.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appNDS_SpriteExporter PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appNDS_SpriteExporter
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appNDS_SpriteExporter
    PRIVATE Qt6::Quick
)
target_link_libraries(appNDS_SpriteExporter PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appNDS_SpriteExporter
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
