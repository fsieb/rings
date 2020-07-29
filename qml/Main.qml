/*
 * Copyright (C) 2020  Frederic SIEBERT
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * rings is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.9
import Ubuntu.Components 1.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3

MainView {
	id: root
	objectName: 'mainView'
	applicationName: 'rings.fsieb'
	automaticOrientation: true

	width: units.gu(45)
	height: units.gu(75)

	Page {
		id: mainPage
		anchors.fill: parent

		header: PageHeader {
			id: header
			title: i18n.tr('')
			Rectangle {
				anchors.fill: parent
				color: "#9ACD32"

				RowLayout {
					id: head_row
					anchors.fill: parent
					anchors.verticalCenter: parent.verticalCenter
					spacing: 20

					Image {
						id: logo
						source: "../assets/image/ring.png"
					}

					Label {
						text: "Rings"
						font.pixelSize: 22
						font.family: "MS Serif"
						color: "#FFFFFF"
					}

					Item {
						// spacer item
						Layout.fillWidth: true
						height: button_menu.height
						Rectangle { anchors.fill: parent; color: "#9ACD32" } // to visualize the spacer
					}

					Image {
						id: button_menu
						source: "../assets/image/help.png"
						MouseArea {
							anchors.fill: parent
							onClicked: { aboutPopup1.open() }
						}
					}
				}
			}
		}

		ToolBar {
			id: toolbar
			width: head_row.width
			RowLayout {
				anchors.fill: parent
				Label {
					text: ""
					elide: Label.ElideRight
					horizontalAlignment: Qt.AlignHCenter
					verticalAlignment: Qt.AlignVCenter
					Layout.fillWidth: true
				}

				ToolButton {
					text: qsTr("Add ring")
					onClicked: addRing.open()
				}
			}
		}

		Rectangle {
			id: listRowDb
			anchors.top: toolbar.bottom  
			width: head_row.width 	
			height: units.gu(100)
			ListModel {
				id: listDb

				ListElement { 	
					name: ""
				}
			}
		
			Component {
				id: listDbDelegate
				Row {
					spacing: 100
					Text { 
                        text: 'Nom de la DB : ' + name
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {python.call('example.speak2', [name], function(returnValue)     {console.log(returnValue)});}
                        }
                    }
				}
			}
			ListView {
				id: listView1
				anchors.fill: parent
				model: listDb
				delegate: listDbDelegate
			}
		}

		Popup {
			id: aboutPopup1
			padding: 10
			width: units.gu(37)
			height: about1a.height + about1b.height + about1c.height + about1d.height + about1Button.height + units.gu(3)
			x: Math.round((parent.width - width) / 2)
			y: Math.round((parent.height - height) / 2)
			z: mainPage.z + 6
			modal: true
			focus: true
			closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

			Text {
				id: about1a
				anchors.top: parent.top
				anchors.left: parent.left
				font.bold: true
				font.pixelSize: units.gu(4.5)
				text: "About this app"
			}

			Text {
				id: about1b
				padding: units.gu(1)
				anchors.top: about1a.bottom
				width: parent.width
				wrapMode: Text.Wrap
				text: "Rings is a simple UBports apps for managing your account and password. The principe is inspired by lord of the rings [one for rules them all]. You create one ring (a encrypted database) and inside multiple rings (account with password information)."
			}

			Text {
				id: about1c
				padding: units.gu(1)
				anchors.top: about1b.bottom
				width: parent.width
				wrapMode: Text.Wrap
				font.bold: true
				text: "Warning: This is a simple apps... use it at your own risks :)"
			}

			Text {
				id: about1d
				padding: units.gu(1)
				anchors.top: about1c.bottom
				width: parent.width
				wrapMode: Text.Wrap
				font.bold: true
				text: "Note: I am not a developper. Feel free to improve my app..."
			}

			Button {
				id: about1Button
				anchors.top: about1d.bottom
				width: parent.width
				text: "Okay"
				onClicked: {
					aboutPopup1.close()
				}
			}
		}
	}

	Python {
		id: python

		Component.onCompleted: {
			addImportPath(Qt.resolvedUrl('../src/'));

			importModule('example', function() {
				console.log('module imported');
				python.call('example.speak', ['Hello World!'], function(returnValue) {
					console.log('example.speak returned ' + returnValue);
				})
				python.call('example.listDb', [], function(returnValue) {
					for(var i=0; i<returnValue.length; i++) {
						listDb.append({"name":returnValue[i]});
					}
				});
			});
		}

		onError: {
			console.log('python error: ' + traceback);
		}
	}
}
