# HOW-TO create a user unit file

copy the unit file to user dir

    mkdir ~/.config/systemd/user/
    cp systemd/template-unit-file/unit-file.service ~/.config/systemd/user/

enable the unit file

    systemctl --user enable unit-file.service
    systemctl --user start unit-file.service    