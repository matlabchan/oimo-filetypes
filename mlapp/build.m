function exit_code = build

project_root = fileparts(mfilename('fullpath'));

project = fullfile(project_root, 'NFLPlayersWebApp.prj');

target_dir = fullfile(project_root, 'NFLPlayersWebApp');
target = fullfile(target_dir, 'NFLPlayers.ctf');

output_dir = fullfile(project_root, computer('arch'));

try
    if exist(target_dir, 'dir')==7
        rmdir(target_dir, 's');
    end

    fprintf(1, 'Building "%s"\n', project);
    deploytool('-build', project);
    counter = 0;
    while counter<100 && exist(target, 'file')~=2
        fprintf('%3d: Waiting for %s...\n', counter, target);
        pause(5);
        counter = counter +1;
    end
    if exist(target, 'file')~=2
      error('%s not built', target);
    end
    fprintf('Copying %s to %s\n', target, output_dir);
    mkdir(output_dir);
    copyfile(target, output_dir);
    exit_code = 0;
catch e
    fprintf(2, '%s', e.message);
    exit_code = 1;
end
