class GVAR(commands) {
    class base {
        name = "command";      // This is what's written in console to provoke this command
        category = "Base";     // used for sorting commands when you type "help". String visible to user
        hidden = 1;         // Used to hide this command from help menu. Boolean.
        help = "";             // Short help text. No more than few words. Should be in format: COMMAND [ARG1] [ARG2]
        helpLong = "";         // Longer help text. Shown to user when they type "help COMMAND". Can be multiple rows. Use <br/> for linebreak
        function = "";         // Code that is called when this command is provoked. Passed params are: ["_command", ["param1", "param2" etc]]
    };

    class help: base {
        name = "help";
        category = "help";
        hidden = 0;
        help = "help [command]";
        helpLong = "Displays help text for given command.<br/>Usage: help [command]";
        function = QUOTE(_this call FUNC(cmd_help));
    };
	class clear: base {
        name = "clear";
        category = "Other";
        hidden = 1;
        help = "clear";
        helpLong = "Clears this console's execution history";
        function = QUOTE(_this call FUNC(cmd_clearConsole));
    };

    class ls: base {
        name = "ls";
        category = "Navigation";
        hidden = 0;
        help = "ls";
        helpLong = "Lists all folders and files in current location";
        function = QUOTE(_this call FUNC(cmd_ls));
    };
    class cd: base {
        name = "cd";
        category = "Navigation";
        hidden = 0;
        help = "cd [directory]";
        helpLong = "Moves to specified path or folder.<br/>Usage: <br/>cd [/home/some/path]<br/>cd [folder-in-current-location]<br/>cd ..   <--moves a step backwards in folders.";
        function = QUOTE(_this call FUNC(cmd_cd));
    };
    class pwd: base {
        name = "pwd";
        category = "Navigation";
        hidden = 0;
        help = "pwd";
        helpLong = "Print Working Directory.<br/>Prints out your current location.";
        function = QUOTE(_this call FUNC(cmd_pwd));
    };
    class mkdir: base {
        name = "mkdir";
        category = "Directory Management";
        hidden = 0;
        help = "mkdir [directory-name]";
        helpLong = "Makes a Directory (folder) in current working directory.<br/>Pass name of directory in params.<br/>At least one parameter is required.";
        function = QUOTE(_this call FUNC(cmd_mkdir));
    };
    class rmdir: base {
        name = "rmdir";
        category = "Directory Management";
        hidden = 0;
        help = "rmdir [directory-name]";
        helpLong = "Removes a Directory (folder) in current working directory.<br/>Pass name of directory in params.<br/>One parameter is required.";
        function = QUOTE(_this call FUNC(cmd_rmdir));
    };
    class date: base {
        name = "date";
        category = "Time & Date";
        hidden = 0;
        help = "date";
        helpLong = "Prints current date and time to console";
        function = QUOTE(_this call FUNC(cmd_date));
    };
    class cat: base {
        name = "cat";
        category = "File Management";
        hidden = 0;
        help = "cat [filename]";
        helpLong = "Prints content of text file to terminal";
        function = QUOTE(_this call FUNC(cmd_cat));
    };

};
