teklab
======

Skripte für Tekbase von Teklab.de


Author: Ulrich Block ich@ulrich-block.de

Kontakt: www.ulrich-block.de

Image Manager v1.9


1. Ziele:
Das erste Ziel ist es, den administrativen Aufwand für die Imageerstellung und Wartung der Gameserver zu minimieren.

Das zweite Ziel ist es, den anfallenden Traffik zu reduzieren. Dies wird durch den Einsatz von Symlinks erreicht. 
Möchte man den Kunden vollständige Installationen bieten, müssen Kapitel 2 bis 7 nicht gelesen werden.


2. Umsetzung:  

2.1. Administrativer Aufwand:
Der Image Manager kann Images für Steam und andere Spiele, Mappackages und Servertools wie Mani Admin und Sourcemod samt der dazugehörigen md5 und .lst Dateien erstellen. 
Alle Vorgänge sind dabei automatisiert und werden über einen Startparameter aufgerufen, so dass sich Updates für einzelne Serverarten samt Images, oder alle auf einmal, mittels Cron automatisieren lassen.

2.2. Struktur und Funktionsweise: 
Die Images enthalten grundsätzlich nur Ordner, Symlinks und Dateien. Dementsprechend sind sie nur wenige MB groß. Die echten Dateien müssen durch den Einsatz von Symlinks pro Root und Spiel nur noch einmal bei dem selben Masteruser vorhanden sein. 
Durch die geringe Größe der Images ist die Installation eines Gameservers, Mappackages, oder Servertools sehr schnell abgeschlossen und es wird bei deren Installation so gut wie kein Traffik verbraucht. Bei Updates muss nur die Masterinstallation geupdated werden, und alle Gameserver laufen mit der aktuellsten Version. 
 
Bei dem Masteruser wird bei der Installation eines Spiels für die Serverdateien, Maps und Servertools jeweils ein spielname-master und spielname-image angelegt. Bei Gameserverroots entfällt das Erstellen der spielname-image Ordner, weil sie nicht benötigt werden.
In dem Verzeichnis master befinden sich alle Dateien, die bei der Installation dieses Images bei allen Usern gleich sein sollen. Dies können z.B. standart Serverdateien von Counter-Strike Source sein.
Aus dem image Verzeichnis wird das Image erstellt. Alle Dateien, die der User später anpassen muss, oder darf, müssen in dieses Verzeichnis. Dieses sind insbesonder Configs, oder Plugins von Servertools.

Damit man die Addon- und Mapdateien nicht auf jeden Root einzeln hochladen werden müssen, gibt es eine Funktion,  die erkennt, welche Spiele bei dem Masteruser installiert sind. Im Folgenden werden dann die master Verzeichnisse dieser Spiele mit dem Programm lftp abgeglichen und bei Bedarf Dateien nachgeladen. Ein manueller Upload ist somit nur bei dem Root erforderlich, von dem die Images gestellt werden.
Ein direkter SSH2 Zugriff auf den Masteruser wird durch den Einsatz von lftp nicht benötigt. 

2.3. md5 und .lst Dateien:
Bei Gameserverimages wird die .md5 Datei automatisch erstellt. Bei Addons und Mappackages werden alle Dateien von selber in die .lst Datei geschrieben.
Darüber hinaus wird bei Mappackages automatisch eine Mapliste im .txt Format im Image hinterlegt, so dass der User die Maps per Copy und Paste zu seinem Mapcycle hinzufügen kann.


3. Reduzierte Ladezeiten und Ramverbrauch:
Läuft bereits ein Gameserver sind die Dateien des Masterverzeichnisses bereits in den Ram geladen worden. 
Wird nun ein zweiter Gameserver gestartet, sind die Masterdateien schon im Ram vorhanden, so dass ein erneutes Laden nicht mehr erforderlich ist. 
Das Starten der Gameserver und der Mapwechsel verläuft deshalb merklich schneller. Dazu sinkt der Verbrauch an Ram.


4. Traffikersparnis:
An dem Imageserver und den Rootservern fällt nur noch der Traffik für eine Installation und deren Updates an. Am Beispiel von Counter-Strike Source mit ca. 3GB bedeutet dies:
Bei 8 Installationen auf einem Rootserver fallen danach bei echten Dateien insgesamt ca. 48GB Traffik, aufgeteilt auf 24GB pro Server, an. Nicht eingerechnet die 3GB an Traffik, die man aufwenden muss, um das Image erstellen zu können.
Nutzt man den Image Manager und mit ihm Symlinks, fallen pro Root und Spiel nur 2GB für das Anlegen der Masterinstalltion an. Der Traffik für Images mit einer Größe im einstelligen MB Bereich ist zu vernachlässigen.

Das Gleiche gilt auch für Mappackages. Man kann jetzt dem Kunden XX GB große Mappackes anbieten, ohne Sorgen haben zu müssen, dass der anfallende Traffik explodiert, da das vom Kunden  installierte Image in aller Regel kleiner als 1MB groß ist
.

5. Zeitersparniss durch den Imagemanager:
Wie bereits beschrieben, muss pro Spiel und Rootserver nur noch eine Installation gepflegt werden. Die Installationspflege kann mit Cron kann sehr einfach automatisiert werden. 
Der Zeitaufwand, bei einem Fehlschlagen von "-autoupdate", der beim manuellen Updaten anfallen würde, entfällt somit. 
Liegt ein Spiel mit Punkbuster vor, wird dieser erkannt und ein Update angestoßen. Das manuelle Updaten des Punkbusters entfällt.

Durch die geringe Anzahl an echten Installationen hat man im Falle eines "required" Updates die  Server wesentlich schneller wieder am laufen, was die Nachfragen der User, warum der Server , oder der Punkbuster nicht aktuell ist, reduzieren und somit Zeit sparen sollte.

Des Weiteren läuft die Installation der Images wegen der minimalen Größe wesentlich schneller ab. Oft ist der Gameserver wenige Sekunden, nachdem man den Installationsvorgang gestartet hat, verfügbar.

Dies gilt natürlich auch bei den so genannten "Protected Severn". Dieser Modus ist wesentlich schneller aktiviert, weil das zu entpackende Image nur eine minimale Größe aufweist. Die User werden ihnen die Zeitersparnis danken.

Bei manchem Filesystemen und oder Kerneln kommt es zu einem merkbaren Performanceverlust, wenn man ein großes Archiv entpackt. 
Ein wesentlich kürzerer Entpackvorgang bedeutet auch, dass andere User davon nicht mehr in dem Ausmaß betroffen sein können, wie beim Entpacken eines 3GB großen .tar Archives und deshalb nicht nachfragen, warum es auf ihrem Server geruckelt hat.

Funktionieren Servertools nach dem Update nicht mehr, bzw. bringen den Server zum Absturz, kann man durch den Einsatz des Image Manager Systems mit einem einzigen Update beim Master die Probleme aller Kunden auf einmal beheben. Dazu kann man die User informieren, was man für sie getan hat. 
Auch dies sollte zu weniger Nachfragen der User, warum ihr Server nicht funktioniert führen und somit Zeit einsparen.

6. Umstellung bestehender Installationen:
Wenn schon Serverinstallationen mit echten Dateien bestehen, spielt dies keine Rolle. Sie können parallel zu neuen Servern mit dem Image Manager System auf ein und dem selben Root nach dem alten Muster weiterbetrieben werden. 
Wenn man diese auf das Image Manager System umstellen will, ist dies problemlos möglich. In diesem Falle werden vom Imagemanager automatisch Installationen erkannt, und sofern eine Masterinstall zu dem Spiel vorhanden ist, die Dateien bei der alten Installation gelöscht, die auch beim Master vorliegen. 
Bei der Verwendung dieser Funktion sollten folglich die mapcycle und motd.txt sowie andere Dateien, die bei der Standartinstalltion von Valve vorliegen und von User bearbeiten werden aus der Masterinstallation entfernt werden.


7. Generelles:
Damit die User die verlinkten Masterdateien benutzen können, müssen sie natürlich vorhanden, und für den User erreichbar sein. 
Es ist deswegen erforderlich, dass der User, mit dem man die Images erstellt hat, auch auf dem System vorhanden ist, bei dem die Images später installiert werden. Das Passwort des Users kann unterschiedlich sein. Es kommt alleine darauf an, dass der User vorhanden ist.
Ebenso wichtig ist es, dass die Teklabuser auf diese Dateien auch zugreifen können. Die Chmodrechte der Masterordner und Dateien müssen es deshalb der Gruppe erlauben, die Dateien lesen zu können.

8. Installation:
Der Image Manager wird mit dem User Root installiert. Der Parameter ist dafür "install"
./image_manager install

Startet man die Installtion, wird man als erstes folgendes gefragt:
"Please enter the name of the master and imageuser"
Hier muss man einen User angeben, der noch nicht auf dem System existiert. Der Name ist dabei egal, so dass ihnen die Bezeichnung frei steht. Dieser User muss mit dem Image Manager auf jedem System angelegt und gleich genannt werden, wenn Symlinks eingesetzt werden.

Als nächstes wird man folgendes gefragt:
"Is this server only used for running gameservers? If yes enter "yes" "
Nur, wenn man keine Images auf diesem System erstellen möchte, sollte man yes angeben. Gibt man hier yes ein, dann wird im Folgenden nach den FTP Daten des Servers gefragt, mit dem die Images erstellt werden. Diese werden von dem Image Manager für die Syncronisationsfunktionen benötigt.

Nun sollte der angegebene User mit allen notwendigen Ordnern und Dateien angelegt werden. Zusätzlich wird das Updatetool von Steam und der srcdsupdatecheck von Nephyrin gedownloaded und das Updatetool auf den neuesten Stand gebracht.
Aus diesem Grund wird auch die Eula des Steamupdaters angezeigt, die man mit "yes" bestätigen muss. 

Nun sollte der Image Manager einsatzfähig sein. Um ihn zu benutzen, loggen sie sich bitte mit dem neu angelegten User ein.

9. Die einzelnen Startparameter:

9.1. Generelle Parameter:

9.1.1. "install"
Muss mit dem User root ausgeführt werden.
Mittels des Parameters "install" wird die Installation gestartet, bei der einige Informationen über den Server und den anzulegenen User vom Benutzer abgefragt werden. Im Anschluss werden, je nachdem, was eingeben wurde alle notwendigen Dateien automatisch angelegt.
Nach der Installation sollten folgende Ordner und Dateien im Home Verzeichnis des neu erstellten Users, angelegt worden sein:

./im_addons
./im_config
./im_config/addons_installed.list
./im_config/games_available.list
./im_config/image_manager.config
./im_config/maps_installed.list
./im_config/.ftp
./im_config/games_installed.list
./image_manager
./im_images
./im_images_files
./im_maps
./im_server
./im_server/hldsupdatetool.bin
./im_server/readme.txt
./im_server/steam
./im_server/test1.so
./im_server/test2.so
./im_server/test3.so
./im_temp


9.1.2. "delete_source"
Kann nur mit dem Image Manager User ausgeführt werden.
Es werden alle im master Ordner instrallierten Spiele angezeigt. Wird das Kürzel eines installierten Spiels eingegeben, so wird dieses, und wenn es sich um den Imagserver handelt auch die Imagefiles gelöscht.

9.1.3. "update_old_installs"
Muss nur mit dem User root ausgeführt werden.
Mit diesem Parameter werden bei schon vorhandenen Installationen die echten Dateien durch Symlinks ersetzt. Dateien, die user bearbeiten muss und solche, die er hochgeladen hat, werden dabei ausgelassen.
Es gibt 3 verschiedene Arten, diesen Parameter zu benutzen. Gezielt Server eines User ändern, alle Server eines Users ändern und alle Server aller User ändern.
Bei allen Arten wird man bei jedem einzelnen Server gefragt, ob man diesen wirklich ändern will, so dass man Server auch auslassen kann.

Beispiele:
./image_manager  update_old_installs kd0001 css cs
Tauscht bei dem User  kd0001 bei den Servern css und cs die Dateien gegen Symlinks aus

./image_manager  update_old_installs kd0001
Listet alle Server des Users kd0001 auf und fragt bei jedem Server, ob bei diesem die Dateien zu Symlinks umgewandelt werden sollen.

./image_manager  update_old_installs kd0001
Listet alle Server des Users kd0001 auf und fragt bei jedem Server, ob bei diesem die Dateien zu Symlinks umgewandelt werden sollen.

9.1.4. "update_im"
Es wird, überprüft, ob ein Update für den Image Manager vorhanden ist, und wenn ja, dann wird es eingespielt.

9.2. Befehle für den Imageserver:

9.2.1. "nosteam"
Kann nur mit dem Image Manager User ausgeführt werden.
Ruft einen Dialog für Server auf, die nicht über Steam bezogen werden können.
Wenn man ein dem Imagemanagementsystem einen Server hinzufügen möchte, der nicht über steam bezogen werden kann, wie zum Beispiel Call of Duty 4, dann muss man dessen Dateien zuerst in den Ordner im_server/teklabkürzel-master hochladen. Im Anschluss den Image Manager mit dem Parameter nosteam starten und den Dialog abarbeiten. 
Mit diesem Dialog können auch die Images geupdated, oder entfernt werden.

9.2.2. "update_source"
Kann nur mit dem Image Manager User ausgeführt werden.
Erfordert die zusätzliche Angabe der Steam- und Teklababkürzung. Für Counter-Strike: Source muss man anstelle der Steam Bezeichnung css verwenden. Aufgerufen wird der Parameter wie folgt:
(Counter-Strike Source) ./image_manager update_source css css
(CS 1.6)  ./image_manager update_source cstrike cs
(CS Zero)  ./image_manager update_source czero csz
(DODS)  ./image_manager update_source dods dods
(TF2)  ./image_manager update_source tf tf

Mit dieser Funktion wird der entsprechende Gameserver, so wie das dazugehörige Image, installiert und auch geupdatet. Die hier angegebe Liste ist nicht abschließend. Man kann alle Server anlegen, die von Steam unterstützt werden.

9.2.3. "update_image"
Kann nur mit dem Image Manager User ausgeführt werden.
Es gilt das Gleiche wie bei "update_source"
Der Unterschied ist, dass bei diesem Parameter nur das Image neu gemacht wird, wenn ein Update des Gameservers vorliegt. Ein Image Update kann mit dem zusätzlichen Parameter "f" erzwungen werden: "./image_manager update_image steamhorten teklabshorten f"

9.2.4. "update_all_sources"
Kann nur mit dem Image Manager User ausgeführt werden.
Überprüft, welche Server installiert sind und startet für alle den Updatevorgang mit dem Parameter update_source. Wenn man mehr als eine Serverart verwendet empfiehlt es sich diesen Parameter in verbindung mit Cron zu benutzen.

9.2.6. "mapinstall"
Kann nur mit dem Image Manager User ausgeführt werden.
Um ein Mappackage zu erstellen, muss man in dem Ordner "im_maps/teklabkürzel-master" einen Unterordner mit dem Namen des Mappackes erstellen. In diesem muss die selbe Ordnerstruktur, wie beim Gameserver vorhanden sein. 
Bei Counter-Strike Source wäre dies:
./im_maps
./im_maps/css-master
./im_maps/css-master/neuemaps
./im_maps/css-master/neuemaps/orangebox
./im_maps/css-master/neuemaps/orangebox/cstrike
./im_maps/css-master/neuemaps/orangebox/cstrike/maps


Nachdem man die Maps hochgeladen hat, ruft man den Image Manager mit dem Parameter "mapinstall" auf. Das neu hinzugefügte Mappackage wird automatisch erkannt und die Frage gestellt, ob ein Image dazu erstellt werden soll. Wenn diese mit Ja beantwortet wird, dann wird ein Image mit dem Namen css-mapneuemaps.tar samt .lst Datei erstellt.

9.2.6 "mapupdate"
Kann nur mit dem Image Manager User ausgeführt werden.
Möchte man Maps einem bestehenden Package hinzufügen, oder entfernen, dann muss dieser Parameter nach der Veränderung im Mappacke  genutzt werden.

9.2.7. "mapremove"
Kann nur mit dem Image Manager User ausgeführt werden.
Die verfügbaren Serverarten und deren Mappackages werden angezeigt. Man gibt wählt nun die Serverart und das Mappackage aus,  das entfernt werden soll. Hat man dies getan, dann wird das Image hierzu, aber nicht die hochgeladenen Dateien gelöscht.

9.2.8. "addoninstall"
Kann nur mit dem Image Manager User ausgeführt werden.
Es gilt das Gleiche, wie bei "mapinstall". Der Unterschied besteht nur da drin, dass man die Dateien im "im_addons" Ordner organisieren muss. 
Bei der Installation von Addons wird man nach Masterordnern gefragt, der bei Sourcemod z.B. sourcemod ist. Diese Ordner werden dann der Dateiliste hinzugefügt, mittels der Tekbase Addons wieder löscht. Dabei muss man nicht den kompletten Pfad eingeben. Es reicht aus, den Ordner anzugeben, der samt seiner Unterordner von Tekbase entfernt werden soll. Mehrere Ordner gibt man getrennt durch ein Leerzeichen an. Ist der angegebene Ordner in zwei Pfaden vorhanden, werden beide der Dateiliste hinzugefügt.

Wenn man z.B. Metamod Source und Sourcemod in einem Addonpacket hat, gibt an folgendes ein:
metamod sourcemod

Diese Eingabe hat zur Folge, dass folgende Ordner hinzugefügt werden:
./orangebox/cstrike/addons/metamod
./orangebox/cstrike/addons/sourcemod
./orangebox/cstrike/cfg/sourcemod


9.2.9. "addonupdate"
Kann nur mit dem Image Manager User ausgeführt werden.
S.h. "mapupdate".

9.2.10. "addonremove"
Kann nur mit dem Image Manager User ausgeführt werden.
S.h. "mapremove"

9.2.11. "nemrun_check_image"
Kann nur mit dem Image Manager User ausgeführt werden.
Überprüft mittels Nephyrins srcdscheck alle installierten Server auf Updates und started, so eines vorliegt, den Updatevorgang, der auch die Images erneuert.
Dieser Parameter ist für einen Cronjob gedacht, den man alle X Stunden, oder Minuten ausführen lässt.

9.3. Befehle für den Gameroot:

9.3.1. "update_gamefiles"
Kann nur mit dem Image Manager User ausgeführt werden.
Das Pendant zu "update_source". Dieser Parameter wird wie "update_source" verwendet:
./image_manager css css

Der Unterschied ist, dass "update_gamefiles" keinen image Ordner und dazugehöriges Image erstellt.

9.3.2. "update_customers"
Scannt nach Serverinstallationen von Usern, erkennt automatisch, um welches Spiel es sich handelt, löscht ggf. verweiste Symlinks und erstellt bei Bedarf neue, wenn ein Update neue Dateien mit sich gebracht hat.

9.3.3. "update_all_gamefiles" 
Kann nur mit dem Image Manager User ausgeführt werden.
Aktualisiert alle installierten Gameserver auf einmal. 

9.3.4. "sync_addons"
Kann nur mit dem Image Manager User ausgeführt werden.
Baut mittels des Programms "lftp" eine Verbindung zum Imageserver auf, um die Dateien der Addons mit diesem abzugleichen. Der Abgleich wird dabei nur für Spiele gemacht, die auch auf dem Gameroot installiert sind. Alternativ kann man auch die Addons manuell uploaden.

9.3.5. "sync_maps"
Kann nur mit dem Image Manager User ausgeführt werden.
Die gleiche Funktion wie "sync_addons", nur für mappackges.

9.3.5. "sync_server"
Kann nur mit dem Image Manager User ausgeführt werden.
Baut mittels des Programms "lftp" eine Verbindung zum Imageserver auf, um die angegebenen Server mit dem Master abzugleichen. Ist der Server auf dem Gameroot noch nicht installiert, wird dies nachgehohlt. Zum Starten muss man die Teklabkürzel der gewünschten Server mitangeben. Um z.B. CSS, CS 1.6 und CS Zero zu installieren/syncroniesieren startet man den Image Manager mit:
./image_manager sync_server css cs csz

9.3.6. "update_addons_customers"
Werden zu einem Servertool neue Dateien hinzugefügt, müssen die Symlinks angepasst werden. Wird der Parameter "update_addons_customers" benutzt, wird nach installierten Servertools gescannt. Wird eine Installtion gefunden, werden verweiset Symlinks entfernt und bei Bedarf neue angelegt.

9.3.9. "update_maps_customers"
Das Pendant zu "update_addons_customers" für Mappackes.

9.3.9. "nemrun_check_game"
Kann nur mit dem Image Manager User ausgeführt werden.
Überprüft mittels Nephyrins srcdscheck alle installierten Server auf Updates und started, so eines vorliegt, den Updatevorgang.
Dieser Parameter ist für einen Cronjob gedacht, den man alle X Stunden, oder Minuten ausführen lässt.

9.4. Images ohne Symlinks
9.4.1. "update_file" 
Identisch mit "update_source". Der Unterschied ist, dass das Image im im_images_files erstellt wird und Dateien anstelle von Symlinks enthält.

9.4.2. "update_image_file"
Identisch mit "update_image". Der Unterschied ist, dass das Image im im_images_files erstellt wird und Dateien anstelle von Symlinks enthält. Mit dem Zusatzparameter f kann das erstellen des Images erzwungen werden, wenn kein Update vorliegt.

9.4.3. "update_all_files"
Identisch mit "update_all_sources". Der Unterschied ist, dass die Image im im_images_files erstellt werden und Dateien anstelle von Symlinks enthalten.

9.4.4. "map_file_update"
Listet installierte Mappackages auf und fragt, zu welchem das Image neu erstellt werden soll. Dabei wird für den User eine .txt Datei erstellt, in der die enthaltenden Maps aufgelistet sind. Dabei werden nur die Dateinamen, nicht aber die Endungen aufgelistet.

9.4.5. "addon_file_update"
Listet installierte Addonpackete auf und fragt, zu welchem das Image neu erstellt werden soll.

Changelog:
1.0
Initial Release


1.1
Fehler behoben, dass bei der Installation das Verzeichnis im_images/addons nicht angelegt wurde.  

Bessere Methode um bestehende Installationen zu erkennen, die bei leeren Verzeichnissen keine Fehler mehr produziert und wesentlich schneller arbeitet.

Die Funktion für das Updaten der Symlinks der Images wurde komplett neu geschrieben und arbeitet nun wesentlich schneller.

Anstelle einen Unterprozesses für das Update von Gameservern  zu starten, wird der Vorgang nun im Hintergrund in einem Screentab gestartet. Im Anschluß daran startet dieser Prozess wieder den Image Manager, um im Bedarfsfalle die Symlinks anzupassen.

1.2
Bei dem Update einer alten Installation zum Image Manager System werden jetzt Dateien steam, test1.so, test2.so test3.so gelöscht.
Wenn bereits ein Update im Gange ist, kann kein neues für die selbe Serverart gestartet werden.
Der Parameter "update_gamefiles_customers"  wurde zu "update_all_gamefiles" umbenannt.
Die Parameter/Funtionen nemrun_check_image nemrun_check_game sind hinzugekommen, welche mittels Nephyrins srcdscheck überprüfen, ob ein Update vorliegt und wenn ja dieses starten.
Die Addon- und Mapimages wurden in spielkürzel-a-imagename.tar und  spielkürzel-m-imagename.tar umbenannt.

1.3
Fehler behoben, dass kein Counter-Strike 1.6 Update gestartet werden kann, wenn bereits ein Counter-Strike Source Update läuft
Für das Updaten eines Systems mit echten Dateien auf das Image Manager System, müssen nun keine Dateien mehr aus dem Masterordner von Hand entfernt werden.
Beim Anlegen der Images werden relevante .smx, .txt, .gam, .cfg, usw. jetzt automatisch in den Image Ordner verschoben, so dass sie vom installierenden User bearbeitet werden können.

1.4
Bei Spielen mit Punkbuster wird dieser nun geupdated.
Fehler beim Erstellen von protected Images behoben.
Die Funktion "update_image" updated die Images jetzt nur noch, wenn ein Update des Gameservers vorliegt. Ein Image Update kann mit dem zusätzlichen Parameter "f" erzwungen werden: "./image_manager update_image steamhorten teklabshorten f"
Nachtragen eventuell fehlender Symlinks bei bereits installierten Servern wurde beschleunigt.
Diverse kleinere Optimierungen des Codes.

1.5
Es können zu den Symlinks nun auch alternativ Images erstellt werden, die keine Symlinks enthalten. Die Vorzüge eines Symlinksystems haben diese Images natürlich nicht. Die dazugehörigen neuen Parameter update_file, update_image_file, update_all_files, map_file_update, addon_file_update
Images mit echten Dateien brauchen beim Erstellen wesentlich mehr Zeit, als Symlink. Aus diesem Grund wurden die Statusmeldungen, was der Image Manager gerade macht, erweitert, so dass jetzt detailierter und öfter berichtet wird, bei welchen Schritt er sich gerade befindet.

1.6
Der Image Manager speichert nun alle Aktionen in der Logdatei im_server/_image_manager.log.
Nicht kritischen Fehler behoben, dass jedes Spiel mit Punkbuster auch zusätzlich als Spiel ohne Punkbuster erkannt wurde. Der Fehler hatte zur Folge, dass es eine Meldung in der Konsole gab, dass man das Image im Bedarfsfall manuell updaten soll.
Fehler in der image_manager.config werden sofern möglich, nun von selber behoben.
Fehlende Standartordner wie z.B. im_server werden nun automatisch neu erstellt, sollte der User sie aus Versehen gelöscht haben.

1.7
Der Image Manager kann sich jetzt selber updaten, wenn eine neue Version vorliegt. Um diese Funktion zu nutzen AUTOUPDATE=1 in der image_manager.config setzen
Der nue Startparamter update_im ist hinzugekommen, mit dem man den Image Manager updaten kann, wenn AUTOUPDATE=0 gesetzt ist.
Man kann nun zusätzlich für HLTV und SourceTV TV Server anlegen. Die Bezeichnung hierfür ist z.B. css-tv, cs-tv, tf-tv, usw.
Die Abfrage, ob Addons/Mappackages bereits installiert sind, wurde überarbeitet.
Bei der Installation von  Addons/Mappackages wurde die Userinputvalidierung erweitert.
Bei der Installation von Addons wird man nun nach dem Masterordner gefragt, der bei Sourcemod z.B. sourcemod ist. Dieser Ordner wird dann der Dateiliste hinzugefügt, mittels der Tekbase Addons wieder löscht.
Der Parameter "sync_server" ist neu hinzugekommen. Hat man beim Installationsvorgang die FTP Daten eines Masterservers angegeben, kann man mit diesem Parameter die Servern Synchroniesieren.
Die Funktion zum umstellen alter Installationen auf Symlinks wurde überarbeitet. Man kann jetzt alle Installationen aller User, alle Installationen eines Users, oder gezielt einzelne Installationen  umwandeln.
Der Output des Image Managers ist nun größtenteils Farbig. Fehler werden in roter, erfolgreiche Aktionen in grüner, Aufforderungen an den User in cyanfarbiger und Benachrichtigungen in gelber Schrift dargestellt.
Es gibt nun das zusätzliche Verzeichnis im_logs für die Logdateien.
