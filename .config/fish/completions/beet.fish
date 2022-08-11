
function __fish_beet_needs_command
    set cmd (commandline -opc)
    if test (count $cmd) -eq 1
        return 0
    end
    return 1
end

function __fish_beet_using_command
    set cmd (commandline -opc)
    set needle (count $cmd)
    if test $needle -gt 1
        if begin test $argv[1] = $cmd[2];
            and not contains -- $cmd[$needle] $FIELDS; end
                return 0
        end
    end
    return 1
end

function __fish_beet_use_extra
    set cmd (commandline -opc)
    set needle (count $cmd)
    if test $argv[2]  = $cmd[$needle]
        return 0
    end
    return 1
end

set CMDS completion config fetchart fields fish ? help imp im import ls list lyrics mod modify mv move rm remove scrub stats upd up update version wlg write

set FIELDS acoustid_fingerprint: acoustid_id: added: album: album_id: albumartist: albumartist_credit: albumartist_sort: albumdisambig: albumstatus: albumtotal: albumtype: albumtypes: arranger: artist: artist_credit: artist_sort: artpath: asin: bitdepth: bitrate: bitrate_mode: bpm: catalognum: channels: comments: comp: composer: composer_sort: country: day: disc: discogs_albumid: discogs_artistid: discogs_labelid: disctitle: disctotal: encoder: encoder_info: encoder_settings: filesize: format: genre: grouping: id: initial_key: isrc: label: language: length: lyricist: lyrics: mb_albumartistid: mb_albumid: mb_artistid: mb_releasegroupid: mb_releasetrackid: mb_trackid: mb_workid: media: month: mtime: original_day: original_month: original_year: path: r128_album_gain: r128_track_gain: releasegroupdisambig: rg_album_gain: rg_album_peak: rg_track_gain: rg_track_peak: samplerate: script: singleton: style: title: track: trackdisambig: tracktotal: work: work_disambig: year:


# ====== setup basic beet completion =====

complete -c beet -n '__fish_beet_needs_command' -l format-item -f -d 'print with custom format'
complete -c beet -n '__fish_beet_needs_command' -l format-album -f -d 'print with custom format'
complete -c beet -n '__fish_beet_needs_command' -s  l  -l library -f -r -d 'library database file to use'
complete -c beet -n '__fish_beet_needs_command' -s  d  -l directory -f -r -d 'destination music directory'
complete -c beet -n '__fish_beet_needs_command' -s  v  -l verbose -f -d 'print debugging information'
complete -c beet -n '__fish_beet_needs_command' -s  c  -l config -f -r -d 'path to configuration file'
complete -c beet -n '__fish_beet_needs_command' -s  h  -l help -f -d 'print this help message and exit'

# ====== setup field completion for subcommands =====

# ------ fieldsetups for  completion -------
complete -c beet -n '__fish_beet_needs_command' -a completion -f -d 'print shell script that provides command line completion'
complete -c beet -n '__fish_beet_using_command completion' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  config -------
complete -c beet -n '__fish_beet_needs_command' -a config -f -d 'show or edit the user configuration'
complete -c beet -n '__fish_beet_using_command config' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  fetchart -------
complete -c beet -n '__fish_beet_needs_command' -a fetchart -f -d 'download album art'
complete -c beet -n '__fish_beet_using_command fetchart' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  fields -------
complete -c beet -n '__fish_beet_needs_command' -a fields -f -d 'show fields available for queries and format strings'
complete -c beet -n '__fish_beet_using_command fields' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  fish -------
complete -c beet -n '__fish_beet_needs_command' -a fish -f -d 'generate Fish shell tab completions'
complete -c beet -n '__fish_beet_using_command fish' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  \? -------
complete -c beet -n '__fish_beet_needs_command' -a \? -f -d 'give detailed help on a specific sub-command'
complete -c beet -n '__fish_beet_using_command \?' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  help -------
complete -c beet -n '__fish_beet_needs_command' -a help -f -d 'give detailed help on a specific sub-command'
complete -c beet -n '__fish_beet_using_command help' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  imp -------
complete -c beet -n '__fish_beet_needs_command' -a imp -f -d 'import new music'
complete -c beet -n '__fish_beet_using_command imp' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  im -------
complete -c beet -n '__fish_beet_needs_command' -a im -f -d 'import new music'
complete -c beet -n '__fish_beet_using_command im' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  import -------
complete -c beet -n '__fish_beet_needs_command' -a import -f -d 'import new music'
complete -c beet -n '__fish_beet_using_command import' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  ls -------
complete -c beet -n '__fish_beet_needs_command' -a ls -f -d 'query the library'
complete -c beet -n '__fish_beet_using_command ls' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  list -------
complete -c beet -n '__fish_beet_needs_command' -a list -f -d 'query the library'
complete -c beet -n '__fish_beet_using_command list' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  lyrics -------
complete -c beet -n '__fish_beet_needs_command' -a lyrics -f -d 'fetch song lyrics'
complete -c beet -n '__fish_beet_using_command lyrics' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  mod -------
complete -c beet -n '__fish_beet_needs_command' -a mod -f -d 'change metadata fields'
complete -c beet -n '__fish_beet_using_command mod' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  modify -------
complete -c beet -n '__fish_beet_needs_command' -a modify -f -d 'change metadata fields'
complete -c beet -n '__fish_beet_using_command modify' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  mv -------
complete -c beet -n '__fish_beet_needs_command' -a mv -f -d 'move or copy items'
complete -c beet -n '__fish_beet_using_command mv' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  move -------
complete -c beet -n '__fish_beet_needs_command' -a move -f -d 'move or copy items'
complete -c beet -n '__fish_beet_using_command move' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  rm -------
complete -c beet -n '__fish_beet_needs_command' -a rm -f -d 'remove matching items from the library'
complete -c beet -n '__fish_beet_using_command rm' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  remove -------
complete -c beet -n '__fish_beet_needs_command' -a remove -f -d 'remove matching items from the library'
complete -c beet -n '__fish_beet_using_command remove' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  scrub -------
complete -c beet -n '__fish_beet_needs_command' -a scrub -f -d 'clean audio tags'
complete -c beet -n '__fish_beet_using_command scrub' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  stats -------
complete -c beet -n '__fish_beet_needs_command' -a stats -f -d 'show statistics about the library or a query'
complete -c beet -n '__fish_beet_using_command stats' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  upd -------
complete -c beet -n '__fish_beet_needs_command' -a upd -f -d 'update the library'
complete -c beet -n '__fish_beet_using_command upd' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  up -------
complete -c beet -n '__fish_beet_needs_command' -a up -f -d 'update the library'
complete -c beet -n '__fish_beet_using_command up' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  update -------
complete -c beet -n '__fish_beet_needs_command' -a update -f -d 'update the library'
complete -c beet -n '__fish_beet_using_command update' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  version -------
complete -c beet -n '__fish_beet_needs_command' -a version -f -d 'output version information'
complete -c beet -n '__fish_beet_using_command version' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  wlg -------
complete -c beet -n '__fish_beet_needs_command' -a wlg -f -d 'get genres with whatlastgenre'
complete -c beet -n '__fish_beet_using_command wlg' -a '$FIELDS' -f -d 'fieldname'

# ------ fieldsetups for  write -------
complete -c beet -n '__fish_beet_needs_command' -a write -f -d 'write tag information to files'
complete -c beet -n '__fish_beet_using_command write' -a '$FIELDS' -f -d 'fieldname'



# ====== completions for  completion =====
complete -c beet -n '__fish_beet_using_command completion' -s h -l help -f -d 'print help'


# ====== completions for  config =====
complete -c beet -n '__fish_beet_using_command config' -s p -l paths -f -d 'show files that configuration was loaded from'
complete -c beet -n '__fish_beet_using_command config' -s e -l edit -f -d 'edit user configuration with $EDITOR'
complete -c beet -n '__fish_beet_using_command config' -s d -l defaults -f -d 'include the default configuration'
complete -c beet -n '__fish_beet_using_command config' -s c -l clear -f -d 'do not redact sensitive fields'
complete -c beet -n '__fish_beet_using_command config' -s h -l help -f -d 'print help'


# ====== completions for  fetchart =====
complete -c beet -n '__fish_beet_using_command fetchart' -s f -l force -f -d 're-download art when already present'
complete -c beet -n '__fish_beet_using_command fetchart' -s q -l quiet -f -d 'quiet mode: do not output albums that already have artwork'
complete -c beet -n '__fish_beet_using_command fetchart' -s h -l help -f -d 'print help'


# ====== completions for  fields =====
complete -c beet -n '__fish_beet_using_command fields' -s h -l help -f -d 'print help'


# ====== completions for  fish =====
complete -c beet -n '__fish_beet_using_command fish' -s f -l noFields -f -d 'omit album/track field completions'
complete -c beet -n '__fish_beet_using_command fish' -r -s e -l extravalues -f -a 'id path album_id title artist artist_sort artist_credit album albumartist albumartist_sort albumartist_credit genre style discogs_albumid discogs_artistid discogs_labelid lyricist composer composer_sort work mb_workid work_disambig arranger grouping year month day track tracktotal disc disctotal lyrics comments bpm comp mb_trackid mb_albumid mb_artistid mb_albumartistid mb_releasetrackid trackdisambig albumtype albumtypes label acoustid_fingerprint acoustid_id mb_releasegroupid asin isrc catalognum script language country albumstatus media albumdisambig releasegroupdisambig disctitle encoder rg_track_gain rg_track_peak rg_album_gain rg_album_peak r128_track_gain r128_album_gain original_year original_month original_day initial_key length bitrate bitrate_mode encoder_info encoder_settings format samplerate bitdepth channels mtime added singleton filesize id artpath added albumartist albumartist_sort albumartist_credit album genre style discogs_albumid discogs_artistid discogs_labelid year month day disctotal comp mb_albumid mb_albumartistid albumtype albumtypes label mb_releasegroupid asin catalognum script language country albumstatus albumdisambig releasegroupdisambig rg_album_gain rg_album_peak r128_album_gain original_year original_month original_day path albumtotal' -d 'include specified field *values* in completions'
complete -c beet -n '__fish_beet_using_command fish' -r -s o -l output -f -d 'where to save the script. default: ~/.config/fish/completions'
complete -c beet -n '__fish_beet_using_command fish' -s h -l help -f -d 'print help'


# ====== completions for  \? =====
complete -c beet -n '__fish_beet_using_command \?' -s h -l help -f -d 'print help'


# ====== completions for  help =====
complete -c beet -n '__fish_beet_using_command help' -s h -l help -f -d 'print help'


# ====== completions for  imp =====
complete -c beet -n '__fish_beet_using_command imp' -s c -l copy -f -d 'copy tracks into library directory (default)'
complete -c beet -n '__fish_beet_using_command imp' -s C -l nocopy -f -d "don't copy tracks (opposite of -c)"
complete -c beet -n '__fish_beet_using_command imp' -s m -l move -f -d 'move tracks into the library (overrides -c)'
complete -c beet -n '__fish_beet_using_command imp' -s w -l write -f -d "write new metadata to files' tags (default)"
complete -c beet -n '__fish_beet_using_command imp' -s W -l nowrite -f -d "don't write metadata (opposite of -w)"
complete -c beet -n '__fish_beet_using_command imp' -s a -l autotag -f -d 'infer tags for imported files (default)'
complete -c beet -n '__fish_beet_using_command imp' -s A -l noautotag -f -d "don't infer tags for imported files (opposite of -a)"
complete -c beet -n '__fish_beet_using_command imp' -s p -l resume -f -d 'resume importing if interrupted'
complete -c beet -n '__fish_beet_using_command imp' -s P -l noresume -f -d 'do not try to resume importing'
complete -c beet -n '__fish_beet_using_command imp' -s q -l quiet -f -d 'never prompt for input: skip albums instead'
complete -c beet -n '__fish_beet_using_command imp' -r -s l -l log -f -d 'file to log untaggable albums for later review'
complete -c beet -n '__fish_beet_using_command imp' -s s -l singletons -f -d 'import individual tracks instead of full albums'
complete -c beet -n '__fish_beet_using_command imp' -s t -l timid -f -d 'always confirm all actions'
complete -c beet -n '__fish_beet_using_command imp' -s L -l library -f -d 'retag items matching a query'
complete -c beet -n '__fish_beet_using_command imp' -s i -l incremental -f -d 'skip already-imported directories'
complete -c beet -n '__fish_beet_using_command imp' -s I -l noincremental -f -d 'do not skip already-imported directories'
complete -c beet -n '__fish_beet_using_command imp' -l from-scratch -f -d 'erase existing metadata before applying new metadata'
complete -c beet -n '__fish_beet_using_command imp' -l flat -f -d 'import an entire tree as a single album'
complete -c beet -n '__fish_beet_using_command imp' -s g -l group-albums -f -d 'group tracks in a folder into separate albums'
complete -c beet -n '__fish_beet_using_command imp' -l pretend -f -d 'just print the files to import'
complete -c beet -n '__fish_beet_using_command imp' -r -s S -l search-id -f -d 'restrict matching to a specific metadata backend ID'
complete -c beet -n '__fish_beet_using_command imp' -r -l from-logfile -f -d 'read skipped paths from an existing logfile'
complete -c beet -n '__fish_beet_using_command imp' -r -l set -f -d 'set the given fields to the supplied values'
complete -c beet -n '__fish_beet_using_command imp' -s h -l help -f -d 'print help'


# ====== completions for  im =====
complete -c beet -n '__fish_beet_using_command im' -s c -l copy -f -d 'copy tracks into library directory (default)'
complete -c beet -n '__fish_beet_using_command im' -s C -l nocopy -f -d "don't copy tracks (opposite of -c)"
complete -c beet -n '__fish_beet_using_command im' -s m -l move -f -d 'move tracks into the library (overrides -c)'
complete -c beet -n '__fish_beet_using_command im' -s w -l write -f -d "write new metadata to files' tags (default)"
complete -c beet -n '__fish_beet_using_command im' -s W -l nowrite -f -d "don't write metadata (opposite of -w)"
complete -c beet -n '__fish_beet_using_command im' -s a -l autotag -f -d 'infer tags for imported files (default)'
complete -c beet -n '__fish_beet_using_command im' -s A -l noautotag -f -d "don't infer tags for imported files (opposite of -a)"
complete -c beet -n '__fish_beet_using_command im' -s p -l resume -f -d 'resume importing if interrupted'
complete -c beet -n '__fish_beet_using_command im' -s P -l noresume -f -d 'do not try to resume importing'
complete -c beet -n '__fish_beet_using_command im' -s q -l quiet -f -d 'never prompt for input: skip albums instead'
complete -c beet -n '__fish_beet_using_command im' -r -s l -l log -f -d 'file to log untaggable albums for later review'
complete -c beet -n '__fish_beet_using_command im' -s s -l singletons -f -d 'import individual tracks instead of full albums'
complete -c beet -n '__fish_beet_using_command im' -s t -l timid -f -d 'always confirm all actions'
complete -c beet -n '__fish_beet_using_command im' -s L -l library -f -d 'retag items matching a query'
complete -c beet -n '__fish_beet_using_command im' -s i -l incremental -f -d 'skip already-imported directories'
complete -c beet -n '__fish_beet_using_command im' -s I -l noincremental -f -d 'do not skip already-imported directories'
complete -c beet -n '__fish_beet_using_command im' -l from-scratch -f -d 'erase existing metadata before applying new metadata'
complete -c beet -n '__fish_beet_using_command im' -l flat -f -d 'import an entire tree as a single album'
complete -c beet -n '__fish_beet_using_command im' -s g -l group-albums -f -d 'group tracks in a folder into separate albums'
complete -c beet -n '__fish_beet_using_command im' -l pretend -f -d 'just print the files to import'
complete -c beet -n '__fish_beet_using_command im' -r -s S -l search-id -f -d 'restrict matching to a specific metadata backend ID'
complete -c beet -n '__fish_beet_using_command im' -r -l from-logfile -f -d 'read skipped paths from an existing logfile'
complete -c beet -n '__fish_beet_using_command im' -r -l set -f -d 'set the given fields to the supplied values'
complete -c beet -n '__fish_beet_using_command im' -s h -l help -f -d 'print help'


# ====== completions for  import =====
complete -c beet -n '__fish_beet_using_command import' -s c -l copy -f -d 'copy tracks into library directory (default)'
complete -c beet -n '__fish_beet_using_command import' -s C -l nocopy -f -d "don't copy tracks (opposite of -c)"
complete -c beet -n '__fish_beet_using_command import' -s m -l move -f -d 'move tracks into the library (overrides -c)'
complete -c beet -n '__fish_beet_using_command import' -s w -l write -f -d "write new metadata to files' tags (default)"
complete -c beet -n '__fish_beet_using_command import' -s W -l nowrite -f -d "don't write metadata (opposite of -w)"
complete -c beet -n '__fish_beet_using_command import' -s a -l autotag -f -d 'infer tags for imported files (default)'
complete -c beet -n '__fish_beet_using_command import' -s A -l noautotag -f -d "don't infer tags for imported files (opposite of -a)"
complete -c beet -n '__fish_beet_using_command import' -s p -l resume -f -d 'resume importing if interrupted'
complete -c beet -n '__fish_beet_using_command import' -s P -l noresume -f -d 'do not try to resume importing'
complete -c beet -n '__fish_beet_using_command import' -s q -l quiet -f -d 'never prompt for input: skip albums instead'
complete -c beet -n '__fish_beet_using_command import' -r -s l -l log -f -d 'file to log untaggable albums for later review'
complete -c beet -n '__fish_beet_using_command import' -s s -l singletons -f -d 'import individual tracks instead of full albums'
complete -c beet -n '__fish_beet_using_command import' -s t -l timid -f -d 'always confirm all actions'
complete -c beet -n '__fish_beet_using_command import' -s L -l library -f -d 'retag items matching a query'
complete -c beet -n '__fish_beet_using_command import' -s i -l incremental -f -d 'skip already-imported directories'
complete -c beet -n '__fish_beet_using_command import' -s I -l noincremental -f -d 'do not skip already-imported directories'
complete -c beet -n '__fish_beet_using_command import' -l from-scratch -f -d 'erase existing metadata before applying new metadata'
complete -c beet -n '__fish_beet_using_command import' -l flat -f -d 'import an entire tree as a single album'
complete -c beet -n '__fish_beet_using_command import' -s g -l group-albums -f -d 'group tracks in a folder into separate albums'
complete -c beet -n '__fish_beet_using_command import' -l pretend -f -d 'just print the files to import'
complete -c beet -n '__fish_beet_using_command import' -r -s S -l search-id -f -d 'restrict matching to a specific metadata backend ID'
complete -c beet -n '__fish_beet_using_command import' -r -l from-logfile -f -d 'read skipped paths from an existing logfile'
complete -c beet -n '__fish_beet_using_command import' -r -l set -f -d 'set the given fields to the supplied values'
complete -c beet -n '__fish_beet_using_command import' -s h -l help -f -d 'print help'


# ====== completions for  ls =====
complete -c beet -n '__fish_beet_using_command ls' -s a -l album -f -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command ls' -s p -l path -f -d 'print paths for matched items or albums'
complete -c beet -n '__fish_beet_using_command ls' -r -s f -l format -f -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command ls' -s h -l help -f -d 'print help'


# ====== completions for  list =====
complete -c beet -n '__fish_beet_using_command list' -s a -l album -f -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command list' -s p -l path -f -d 'print paths for matched items or albums'
complete -c beet -n '__fish_beet_using_command list' -r -s f -l format -f -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command list' -s h -l help -f -d 'print help'


# ====== completions for  lyrics =====
complete -c beet -n '__fish_beet_using_command lyrics' -s p -l print -f -d 'print lyrics to console'
complete -c beet -n '__fish_beet_using_command lyrics' -r -s r -l write-rest -f -d 'write lyrics to given directory as ReST files'
complete -c beet -n '__fish_beet_using_command lyrics' -s f -l force -f -d 'always re-download lyrics'
complete -c beet -n '__fish_beet_using_command lyrics' -s l -l local -f -d 'do not fetch missing lyrics'
complete -c beet -n '__fish_beet_using_command lyrics' -s h -l help -f -d 'print help'


# ====== completions for  mod =====
complete -c beet -n '__fish_beet_using_command mod' -s m -l move -f -d 'move files in the library directory'
complete -c beet -n '__fish_beet_using_command mod' -s M -l nomove -f -d "don't move files in library"
complete -c beet -n '__fish_beet_using_command mod' -s w -l write -f -d "write new metadata to files' tags (default)"
complete -c beet -n '__fish_beet_using_command mod' -s W -l nowrite -f -d "don't write metadata (opposite of -w)"
complete -c beet -n '__fish_beet_using_command mod' -s a -l album -f -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command mod' -r -s f -l format -f -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command mod' -s y -l yes -f -d 'skip confirmation'
complete -c beet -n '__fish_beet_using_command mod' -s h -l help -f -d 'print help'


# ====== completions for  modify =====
complete -c beet -n '__fish_beet_using_command modify' -s m -l move -f -d 'move files in the library directory'
complete -c beet -n '__fish_beet_using_command modify' -s M -l nomove -f -d "don't move files in library"
complete -c beet -n '__fish_beet_using_command modify' -s w -l write -f -d "write new metadata to files' tags (default)"
complete -c beet -n '__fish_beet_using_command modify' -s W -l nowrite -f -d "don't write metadata (opposite of -w)"
complete -c beet -n '__fish_beet_using_command modify' -s a -l album -f -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command modify' -r -s f -l format -f -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command modify' -s y -l yes -f -d 'skip confirmation'
complete -c beet -n '__fish_beet_using_command modify' -s h -l help -f -d 'print help'


# ====== completions for  mv =====
complete -c beet -n '__fish_beet_using_command mv' -r -s d -l dest -f -d 'destination directory'
complete -c beet -n '__fish_beet_using_command mv' -s c -l copy -f -d 'copy instead of moving'
complete -c beet -n '__fish_beet_using_command mv' -s p -l pretend -f -d "show how files would be moved, but don't touch anything"
complete -c beet -n '__fish_beet_using_command mv' -s t -l timid -f -d 'always confirm all actions'
complete -c beet -n '__fish_beet_using_command mv' -s e -l export -f -d 'copy without changing the database path'
complete -c beet -n '__fish_beet_using_command mv' -s a -l album -f -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command mv' -s h -l help -f -d 'print help'


# ====== completions for  move =====
complete -c beet -n '__fish_beet_using_command move' -r -s d -l dest -f -d 'destination directory'
complete -c beet -n '__fish_beet_using_command move' -s c -l copy -f -d 'copy instead of moving'
complete -c beet -n '__fish_beet_using_command move' -s p -l pretend -f -d "show how files would be moved, but don't touch anything"
complete -c beet -n '__fish_beet_using_command move' -s t -l timid -f -d 'always confirm all actions'
complete -c beet -n '__fish_beet_using_command move' -s e -l export -f -d 'copy without changing the database path'
complete -c beet -n '__fish_beet_using_command move' -s a -l album -f -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command move' -s h -l help -f -d 'print help'


# ====== completions for  rm =====
complete -c beet -n '__fish_beet_using_command rm' -s d -l delete -f -d 'also remove files from disk'
complete -c beet -n '__fish_beet_using_command rm' -s f -l force -f -d 'do not ask when removing items'
complete -c beet -n '__fish_beet_using_command rm' -s a -l album -f -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command rm' -s h -l help -f -d 'print help'


# ====== completions for  remove =====
complete -c beet -n '__fish_beet_using_command remove' -s d -l delete -f -d 'also remove files from disk'
complete -c beet -n '__fish_beet_using_command remove' -s f -l force -f -d 'do not ask when removing items'
complete -c beet -n '__fish_beet_using_command remove' -s a -l album -f -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command remove' -s h -l help -f -d 'print help'


# ====== completions for  scrub =====
complete -c beet -n '__fish_beet_using_command scrub' -s W -l nowrite -f -d 'leave tags empty'
complete -c beet -n '__fish_beet_using_command scrub' -s h -l help -f -d 'print help'


# ====== completions for  stats =====
complete -c beet -n '__fish_beet_using_command stats' -s e -l exact -f -d 'exact size and time'
complete -c beet -n '__fish_beet_using_command stats' -s h -l help -f -d 'print help'


# ====== completions for  upd =====
complete -c beet -n '__fish_beet_using_command upd' -s a -l album -f -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command upd' -r -s f -l format -f -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command upd' -s m -l move -f -d 'move files in the library directory'
complete -c beet -n '__fish_beet_using_command upd' -s M -l nomove -f -d "don't move files in library"
complete -c beet -n '__fish_beet_using_command upd' -s p -l pretend -f -d 'show all changes but do nothing'
complete -c beet -n '__fish_beet_using_command upd' -r -s F -l field -f -d 'list of fields to update'
complete -c beet -n '__fish_beet_using_command upd' -s h -l help -f -d 'print help'


# ====== completions for  up =====
complete -c beet -n '__fish_beet_using_command up' -s a -l album -f -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command up' -r -s f -l format -f -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command up' -s m -l move -f -d 'move files in the library directory'
complete -c beet -n '__fish_beet_using_command up' -s M -l nomove -f -d "don't move files in library"
complete -c beet -n '__fish_beet_using_command up' -s p -l pretend -f -d 'show all changes but do nothing'
complete -c beet -n '__fish_beet_using_command up' -r -s F -l field -f -d 'list of fields to update'
complete -c beet -n '__fish_beet_using_command up' -s h -l help -f -d 'print help'


# ====== completions for  update =====
complete -c beet -n '__fish_beet_using_command update' -s a -l album -f -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command update' -r -s f -l format -f -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command update' -s m -l move -f -d 'move files in the library directory'
complete -c beet -n '__fish_beet_using_command update' -s M -l nomove -f -d "don't move files in library"
complete -c beet -n '__fish_beet_using_command update' -s p -l pretend -f -d 'show all changes but do nothing'
complete -c beet -n '__fish_beet_using_command update' -r -s F -l field -f -d 'list of fields to update'
complete -c beet -n '__fish_beet_using_command update' -s h -l help -f -d 'print help'


# ====== completions for  version =====
complete -c beet -n '__fish_beet_using_command version' -s h -l help -f -d 'print help'


# ====== completions for  wlg =====
complete -c beet -n '__fish_beet_using_command wlg' -s v -l verbose -f -d 'verbose output (-vv for debug)'
complete -c beet -n '__fish_beet_using_command wlg' -s f -l force -f -d 'force overwrite existing genres'
complete -c beet -n '__fish_beet_using_command wlg' -s u -l update-cache -f -d 'force update cache'
complete -c beet -n '__fish_beet_using_command wlg' -s h -l help -f -d 'print help'


# ====== completions for  write =====
complete -c beet -n '__fish_beet_using_command write' -s p -l pretend -f -d 'show all changes but do nothing'
complete -c beet -n '__fish_beet_using_command write' -s f -l force -f -d 'write tags even if the existing tags match the database'
complete -c beet -n '__fish_beet_using_command write' -s h -l help -f -d 'print help'