# Planning with Thunder Workshop

В репозитории представлены подготовительные инструкции, сцены и docker-образы для участия в семинаре __`"Разработка алгоритма планирования движения с использованием платформы AgileX Robotics Thunder"`__ Летней школы Искусственного Интеллекта 2021 (RAAI Summer School 2021).

## Предварительная подготовка

Для участия в семинаре необходимо установить следующее ПО (рекомендуется использовать дистрибутив [Ubuntu 20.04](https://releases.ubuntu.com/20.04/)):

1. [ROS](http://wiki.ros.org/ROS/Installation) (для Ubuntu 20.04 версии [Noetic](http://wiki.ros.org/noetic/Installation)).
2. Среду симуляции [CoppeliaSim](https://www.coppeliarobotics.com/downloads);
3. [Docker](https://docs.docker.com/engine/install/ubuntu/);

### Установка ROS

Полные инструкции по установке представлены [здесь](http://wiki.ros.org/noetic/Installation/Ubuntu).

Для семинара необходимо установить сборку __`ros-*-desktop-full`__.

### Установка CoppeliaSim

Если архив с симулятором был скачан в директорию `~/Downloads`, то установка производится следующими коммандами:

```bash
tar -Jxf CoppeliaSim_Edu_V4_2_0_Ubuntu20_04.tar.xz --directory=/path/to/your/folder
```

> Для загрузки ROS плагина при запуске CoppeliaSim необходимо сначала запустить `roscore`:
> ```bash
> # terminal 1
> roscore
> # terminal 2
> cd /path/to/your/folder/CoppeliaSim_Edu_V4_2_0_Ubuntu20_04
> ./coppeliaSim.sh   
> ```
> В случае успешной загрузки плагинов вы увидите в терминале 2 сообщения:
> ```bash
> [CoppeliaSim:loadinfo]   plugin 'ROS': loading...
> [CoppeliaSim:loadinfo]   plugin 'ROS': load succeeded.
> ```

### Установка Docker

Рекомендуемый способ установки docker через добавление apt репозитория описан [здесь](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

Кроме того для упрощения дальнейшей работы рекомендуется выполнить [инструкции для работы non-root ползователей](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

## Запуск среды симуляции и готовых компонент


