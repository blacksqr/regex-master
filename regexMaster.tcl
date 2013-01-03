#!/bin/sh
#\
exec wish "$0" "$@"

# regexMaster.tcl
#
#
# by Holger Jakobs, holger@jakobs.com, started 2003-03-19
#
# Mit Hilfe dieses kleinen Programms sollen regulÃ¤re AusdrÃ¼cke
# leichter gelernt und geÃ¼bt werden kÃ¶nnen.
#
# With the help of this little program you can learn and practice
# using regular expressions.

proc ec8 {s} {
    regsub -all {ß} $s "\u00df" s
    regsub -all {Ä} $s "\u00c4" s
    regsub -all {Ö} $s "\u00d6" s
    regsub -all {Ü} $s "\u00dc" s
    return [encoding convertfrom utf-8 $s]
} ;# proc ec8


proc Hilfe {} {
    catch {destroy .hilfe}
    toplevel .hilfe
    set fett [font create -family Helvetica -size 18 -weight bold]
    label .hilfe.l -text "Hilfe zum regexMaster" -font $fett -foreground #444488
    pack .hilfe.l
    
    set tf [frame .hilfe.f]
    pack $tf -expand yes -fill both
    set t [text $tf.t -wrap word -width 90 -height 20 \
            -yscrollcommand "$tf.sb set"]
    scrollbar $tf.sb -orient vertical  -command "$t yview"
    pack $t -side left -expand yes -fill both
    pack $tf.sb -side left -fill y
    
    $t insert end [ec8 {regexMaster dient dazu, den Umgang mit regulären \
                Ausdrücken zu üben. Hierzu gibt es die Möglichkeit, \
                im großen Textfeld einen Text einzugeben oder einen Text \
                dort hinein zu laden.
        
        Im regexMaster werden die regulären Ausdrücke von Tcl \
                (Tool Command Language, http://www.tcl.tk) verwendet, \
                weil das Programm damit geschrieben wurde. Trotzdem \
                werden hier diverse Hilfen aus diversen Quellen zu \
                regulären Ausdrücken angeboten.
        
        Diverse Hilfe zu regulären Ausdrücken:
    }]
    
    button $t.grepre  -text "grep-RE" -command {rehelp grepre}
    button $t.perlre  -text "perl-RE" -command {rehelp perlre}
    button $t.perlrequick -text "perl-RE-quick" -command {rehelp perlrequick}
    button $t.perlretut -text "per-RE-tutorial" -command {rehelp perlretut}
    button $t.re_syntax -text "Tcl-RE" -command {rehelp re_syntax}
    button $t.regex -text "POSIX-RE" -command {rehelp regex}
    button $t.kurz -text "Kurz" -command {rehelp kurz}
    
    $t window create end -window $t.grepre
    $t window create end -window $t.perlre
    $t window create end -window $t.perlrequick
    $t window create end -window $t.perlretut
    $t window create end -window $t.re_syntax
    $t window create end -window $t.regex
    $t window create end -window $t.kurz
    
    $t insert end [ec8 {
        Außerdem sei noch auf das WWW verwiesen:
        http://www.lrz-muenchen.de/services/schulung/unterlagen/regul/
        
        Den regulären Ausdruck gibt man im oberen Feld ein und klickt \
                auf "Prüfen" oder drückt die Eingabetaste. Der reguläre Ausdruck \
                wird auf den Text im Textfeld zeilenweise angewendet. Alle \
                passenden Stellen werden farbig markiert. Außerdem wird die \
                Anzahl passender Zeilen rechts neben dem "Prüfen"-Knopf \
                angezeigt.
        
        Auf diese Weise kann man - im Gegensatz zum Experimentieren \
                mit grep - nicht nur sehen, welche Zeilen auf einen regulären \
                Ausdruck passen, sondern auch, welcher Teil der Zeile passt.
        
        Um Fundstellen sichtbar zu machen, die bei längeren Texten \
                unterhalb des sichbaren Textausschnitts liegen können, \
                kann man mittels des Pfeil-Knopfs die jeweils nächste \
                Fundstelle einblenden. Tip: Falls viele Zeilen passen, muss \
                man den Knopf evtl. oft drücken, bis im Text weitergeblättert \
                wird. Da ist es dann besser, die Bildlaufleisten zu benutzen.
        
        Holger Jakobs, holger@jakobs.com
        
    }]
    
    $t configure -state disabled
    button .hilfe.b -text [ec8 {Schließen}] -command {catch  {destroy .hilfe}}
    pack .hilfe.b
} ;# proc Hilfe

proc Help {} {
    catch {destroy .hilfe}
    toplevel .hilfe
    set fett [font create -family Helvetica -size 18 -weight bold]
    label .hilfe.l -text "help with regexMaster" -font $fett -foreground #444488
    pack .hilfe.l
    
    set tf [frame .hilfe.f]
    pack $tf -expand yes -fill both
    set t [text $tf.t -wrap word -width 90 -height 20 \
            -yscrollcommand "$tf.sb set"]
    scrollbar $tf.sb -orient vertical  -command "$t yview"
    pack $t -side left -expand yes -fill both
    pack $tf.sb -side left -fill y
    
    $t insert end {regexMaster is for practising regular expressions. \
                You can enter text into the large text area or load a \
                text document into it like into an editor.\
                
        regexMaster uses the regular expressions of Tcl, the Tool command \
                Language, http://www.tcl.tk), because the program was \
                written in this language. In spite of this fact help from \
                various sources regarding regular expressions is being \
                offered here.
        
        Various help regarding regular expressions:
    }
    
    button $t.grepre  -text "grep-RE" -command {rehelp grepre}
    button $t.perlre  -text "perl-RE" -command {rehelp perlre}
    button $t.perlrequick -text "perl-RE-quick" -command {rehelp perlrequick}
    button $t.perlretut -text "per-RE-tutorial" -command {rehelp perlretut}
    button $t.re_syntax -text "Tcl-RE" -command {rehelp re_syntax}
    button $t.regex -text "POSIX-RE" -command {rehelp regex}
    button $t.kurz -text "Kurz" -command {rehelp kurz}
    
    $t window create end -window $t.grepre
    $t window create end -window $t.perlre
    $t window create end -window $t.perlrequick
    $t window create end -window $t.perlretut
    $t window create end -window $t.re_syntax
    $t window create end -window $t.regex
    $t window create end -window $t.kurz
    
    $t insert end {
        You can even find lots of material in the World Wide Web.
        
        Enter your regular expression in the field at the top and click "check" \
                or press the "Enter" key. The regular expression will be \
                applied to the text in the text area line by line. All \
                matchings will be marked in color. At the top the number of \
                matching lines will be shown close to the "check" button. \
                
        This way you can easily see which lines and exactly which portion of \
                each line matches. \
                
        To make matches visibile, which can be further down and not in the \
                currently visible part of the text, you can use the arrow button \
                to find further mathes. Using the scroll bar is also possible.
        
        Holger Jakobs, holger@jakobs.com, holg.jako@gmail.com
        
    }
    
    $t configure -state disabled
    button .hilfe.b -text {Close} -command {catch  {destroy .hilfe}}
    pack .hilfe.b
} ;# proc Help

proc rehelp {dateiname} {
    global g
    
    if [catch {open $g(dir)/$dateiname.man} f] {
        tk_messageBox -title ::$t(cannotopenhelp) \
                -icon error -type ok \
                -message "$f"
        return
    } ;# if
    
    set inhalt [read $f]
    close $f
    
    catch {destroy .rehilfe}
    toplevel .rehilfe
    
    set tf [frame .rehilfe.f]
    pack $tf -expand yes -fill both
    set t [text $tf.t -wrap word -width 80 -height 20 \
            -yscrollcommand "$tf.sb set"]
    scrollbar $tf.sb -orient vertical  -command "$t yview"
    pack $t -side left -expand yes -fill both
    pack $tf.sb -side left -fill y
    
    $t insert end "$inhalt"
    
    button .rehilfe.b -text $::t(close) -command {catch  {destroy .rehilfe}}
    pack .rehilfe.b
} ;# proc Hilfe


proc Bildschirm {} {
    global g
    
    set version [lindex {$Revision: 1.1 $} 1]
    
    wm title . "regexMaster v$version"
    
    set fett [font create -family Helvetica -size 30 -weight bold]
    label .titel -text "regexMaster" -font $fett -foreground #444488
    pack .titel -side top
    
    
    ### Frames
    set f_tool  [frame .ftool -relief groove -borderwidth 2]
    ;# fÃ¼r die Toolbox-KnÃ¶pfe
    set f_regex [frame .fregex]  ;# fÃ¼r Eingabe des regulÃ¤ren Ausdrucks
    set f_lines [frame .flines]  ;# fÃ¼r die Anzeige der passenden Zeilen
    
    pack $f_tool  -side top -fill x -padx 1 -pady 1
    pack $f_regex -side top -padx 1 -pady 1
    pack $f_lines -side top -fill both -expand yes -padx 1 -pady 1
    
    ### Toolbox
    image create photo beamer -data {
        R0lGODlhFAAUAKEAAPz8VAAAAPz8/AAAACH+FUNyZWF0ZWQgd2l0aCBUaGUgR0lNUAAh+QQB
        CgADACwAAAAAFAAUAAACQpyPqcvtCIKcdIErstYh3U9RAvWV2xlkQQmG0qiy2MnFsvumowzQ
        9X7DwYAsn8rGwqVIMuPIU1JKLJcHA2DNareKAgA7
    }
    set b_beamer [button $f_tool.beamer -image beamer -command beamerFont]
    pack $b_beamer -side left -padx 3 -pady 1
    image create photo oeffnen -data {
        R0lGODlhEAAQALMAAAAAAISEAMbGxv//AP//////////////////////////////////////
        /////////yH5BAEAAAIALAAAAAAQABAAAAQ4UMhJq6Ug3wpm7xsHZqBFCsBADGTLrbCqllIa
        xzSKt3wmA4GgUPhZAYfDEQuZ9ByZAVqPF6paLxEAOw==
    }
    set b_open [button $f_tool.oeffnen -image oeffnen -command openFile]
    pack $b_open -side left -padx 3 -pady 1
    image create photo speichern -data {
        R0lGODlhEAAQALMAAAAAAISEAMbGxv//////////////////////////////////////////
        /////////yH5BAEAAAIALAAAAAAQABAAAAQ3UMhJqwQ4a30DsJfwiR4oYt1oASWpVuwYm7NL
        t6y3YQHe/8CfrLfL+HQcGwmZSXWYKOWpmDSBIgA7
    }
    set b_save [button $f_tool.speichern -image speichern -command saveFile]
    pack $b_save -side left -padx 3 -pady 1
    image create photo zeigen -data {
        R0lGODlhEAAQAIQAANXa1bS2tGJhYgAAAP///4vW/4vS/ymq/0q2/0q6/wCR3mJlYpTW/2rG
        /yCq/wB5vQB5tL22tJTS////////////////////////////////////////////////////
        /yH+FUNyZWF0ZWQgd2l0aCBUaGUgR0lNUAAsAAAAABAAEAAABWQgIAKBYJ7BqJZD6wqpSgoD
        URjHAMtzjSQKXWxFK/yCi+GIZUgggrsVywgUDkuCxcBw1C12LBc1+AqwGA3ED+E4OB7CnqHh
        dDogg0VkSZv/7nFEAwUNgHo8PRJwUYhhjIgzSTwhADs=
    }
    set b_zeigen [button $f_tool.zeigen -image zeigen -command zeigeFundstelle]
    pack $b_zeigen -side left -padx 3 -pady 1
    
    image create photo progEnde -data {
        R0lGODdhFAAUALMAAMDAwAAAAP//AICAAICAgP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
        AAAAAAAAACH5BAEAAAAALAAAAAAUABQAAARYEMhJq7Uh650vCEQohoEQeOBICsOJpWM5tFem
        yrPLBQVM4LRPYUjsiYA6gXJpSiElu+bRVAhWNLGmlWLLzraT7vTrwtxYOdSZjIrmyp4wCx6X
        0+vQO94TAQA7
    }
    set b_ende [button $f_tool.ende -image progEnde -command exit]
    pack $b_ende -side right -padx 3 -pady 1
    image create photo hilfe -data {
        R0lGODlhEAAQAKEAAAAAAISEAP///////yH5BAEAAAEALAAAAAAQABAAAAIfjI+pywYPmovh
        NXuw0pVu30kZeJEMJ6GlyC7qabZIAQA7
    }
    set b_hilfe [button $f_tool.hilfe -image hilfe -command Hilfe]
    pack $b_hilfe -side right -padx 3 -pady 1
    
    ### Regex-Eingabe
    label  $f_regex.l   -text $::t(regexp)
    set g(regexLabel) $f_regex.l
    entry  $f_regex.e   -width 50 -textvariable g(regex)
    set g(regexEntry) $f_regex.e
    button $f_regex.b   -text $::t(check) -command prÃ¼feRegex
    set g(regexButton) $f_regex.b
    set g(anzahl) [label  $f_regex.anz -text ""]
    pack $f_regex.l $f_regex.e $f_regex.b $g(anzahl) \
            -side left -anchor w -fill x -padx 5 -pady 3
    
    ### Textfenster
    set g(tf) [text $f_lines.tf -wrap none \
            -xscrollcommand "$f_lines.sbx set" \
            -yscrollcommand "$f_lines.sby set"]
    scrollbar $f_lines.sbx -orient horizontal -command {$g(tf) xview}
    scrollbar $f_lines.sby -orient vertical   -command {$g(tf) yview}
    $g(tf) tag configure passend -background cyan
    pack $f_lines.sbx -side bottom -fill x
    pack $g(tf) -side left -expand yes -fill both
    pack $f_lines.sby -side left -fill y
    
    
    ### Balloon-Help
    balloonhelp $b_beamer  $::t(bh_beamer)
    balloonhelp $b_open    $::t(bh_open)
    balloonhelp $b_save    $::t(bh_save)
    balloonhelp $b_ende    $::t(bh_end)
    balloonhelp $b_hilfe   $::t(bh_help)
    balloonhelp $b_zeigen  $::t(bh_show)
    balloonhelp $f_regex.e $::t(bh_entry)
    balloonhelp $f_regex.b $::t(bh_check)
    
    ### Bindings
    bind $f_regex.e <Key-Return> prÃ¼feRegex
    
    ### Bilder zum Markieren der Fundstellen laden
    set g(beginn) [image create photo beginn -data {
        R0lGODlhBQAMAKEAAFCgUP///////////yH5BAEKAAEALAAAAAAFAAwAAAIPRB5gp6j7TJyp
        VbiqQ6EAADs=
    }]
    set g(ende)   [image create photo ende   -data {
        R0lGODlhBQAMAIAAAKBQUP///yH5BAEKAAEALAAAAAAFAAwAAAIPjAMHaduO3Jo0wqlYPKgA
        ADs=
    }]
    
} ;# proc Bildschirm


proc beamerFont {} {
    # Font umstellen fÃ¼r besser Beamer-Sichtbarkeit
    global g
    set beamFont [font create -family Helvetica -size 16]
    $g(tf) configure -font $beamFont
    $g(regexEntry) configure -font $beamFont
    $g(regexLabel) configure -font $beamFont
    $g(regexButton) configure -font $beamFont
    $g(anzahl) configure -font $beamFont
} ;# proc beamerFont


proc zeigeFundstelle {} {
    global g
    set currentLine [$g(tf) index insert]
    foreach fs $g(fundstellen) {
        if {$fs > $currentLine} {
            $g(tf) see $fs.0
            $g(tf) mark set insert $fs.0
            return
        } ;# if
    } ;# foreach
    tk_messageBox -title $::t(hinweis) -icon info -type ok \
            -message $::t(nomorematches)
} ;# proc zeigeFundstelle


proc prÃ¼feRegex {} {
    global g tcl_platform
    
    if [catch {regexp -indices -- $g(regex) - passt} anzahl] {
        tk_messageBox -icon error -title $::t(regexpwrong)  \
                -message $anzahl -type ok
        return
    } ;# if
    
    
    # Text aus Textfenster lesen
    set inhalt [split [$g(tf) get 1.0 end] \n]
    $g(tf) delete 1.0 end
    
    # alte Fundstellenmarkierungen lÃ¶schen
    for {set i 1} {$i <= $g(gesamtAnzahl)} {incr i} {
        destroy $g(tf).beginn$i
        destroy $g(tf).ende$i
    } ;# for
    
    set zeilenNr 0
    set g(gesamtAnzahl) 0
    set ersteZeile 1
    set g(fundstellen) ""
    
    foreach zeile [lrange $inhalt 0 end-1] {
        incr zeilenNr
        if {!$ersteZeile} {$g(tf) insert end "\n"} ;# if
        set ersteZeile 0
        set passt ""
        set anzahl [regexp -indices -- $g(regex) $zeile passt]
        if {$anzahl > 0} {
            incr g(gesamtAnzahl) $anzahl
            set anfang [lindex $passt 0]
            set ende   [lindex $passt 1]
            lappend g(fundstellen) $zeilenNr
            $g(tf) insert end [string range $zeile 0 [expr $anfang -1]]
            set beg [label $g(tf).beginn$g(gesamtAnzahl) -image $g(beginn)]
            set end [label $g(tf).ende$g(gesamtAnzahl)   -image $g(ende)]
            $g(tf) window create end -window $beg
            $g(tf) insert end [string range $zeile $anfang $ende] passend
            $g(tf) window create end -window $end
            $g(tf) insert end [string range $zeile [expr $ende +1] end]
        } else {
            $g(tf) insert end $zeile
        } ;# if
    } ;# foreach
    
    $g(tf) mark set insert 1.0
    $g(anzahl) configure -text "$g(gesamtAnzahl) Matches"
} ;# proc prÃ¼feRegex



proc openFile {} {
    global g
    
    set g(fn) [tk_getOpenFile -title $::t(choosefile)]
    if {$g(fn) == ""} return
    if [catch {open $g(fn) r} f] {
        tk_messageBox -title $::t(cannotopenfile) \
                -message "$f" -icon error -type ok
        return
    } ;# if
    $g(tf) delete 1.0 end
    $g(tf) insert end [read $f]
    $g(tf) mark set insert 1.0
    close $f
} ;# proc openFile


proc saveFile {} {
    global g
    
    set g(fn) [tk_getSaveFile -title $::t(savetexttofile)  \
            -defaultextension ".txt" -initialfile "$g(fn)"]
    if {$g(fn) == ""} return
    if [catch {open $g(fn) w} f] {
        tk_messageBox -title $::t(cannotopenfile) \
                -message "$f" -icon error -type ok
        return
    } ;# if
    puts -nonewline $f [$g(tf) get 1.0 end]
    close $f
} ;# proc saveFile

proc getLanguage {} {
    set lang "en" ;# default
    switch -- $::tcl_platform(platform) {
        unix {
            catch {set lang "[string range $::env(LANG) 0 1]"}
        }
        windows {
            catch {
                package require twapi
                set lang "[lindex [::twapi::get_locale_info [::twapi::get_user_default_langid] -siso639langname] 1]"
            } ;# catch
        }
    } ;# switch
    return $lang
} ;# proc getLanguage


proc InitLocalizedText {} {
    global t
    switch -- [getLanguage] {
        en {
            set t(cannotopenhelp) "cannot open help file"
            set t(choosefile) "Please choose text file"
            set t(regexp) "regular expression: "
            set t(check) " Match "
            set t(bh_beamer)  "Switch to large font for projection"
            set t(bh_open)    "load new text into text area"
            set t(bh_save)    "save content of text area to file"
            set t(bh_end)     "exit program (without saving)"
            set t(bh_help)    "little help"
            set t(bh_show)    "show next match"
            set t(bh_entry)   "entry for regular expression"
            set t(bh_check)   "match regular expression"
            set t(hinweis)    "hint"
            set t(cannotopenfile) "cannot open file"
            set t(savetexttofile) "save text to file"
            set t(regexpwrong) "regular expression is wrong!"
            set t(nomorematches) "no more matches"
            set t(close)       {Close}
            rename Hilfe Hilfe_orig
            rename Help Hilfe
        }
        de {
            set t(cannotopenhelp) [ec8 "Hilfedatei kann nicht geöffnet werden"]
            set t(choosefile) [ec8 "Bitte Textdatei auswählen"]
            set t(regexp)     [ec8 "regulärer Ausdruck: "]
            set t(check)      [ec8 " Prüfen "]
            set t(bh_beamer)  [ec8 "Umschalten auf größeren Font für Beamer-Projektion"]
            set t(bh_open)    "Laden eines neuen Textes ins Textfeld"
            set t(bh_save)    "Speichern des Textes im Textfeld in einer Datei"
            set t(bh_end)     "Verlassen des Programms regexMaster (ohne Speichern)"
            set t(bh_help)    "Kleine Hilfe zum regexMaster"
            set t(bh_show)    [ec8 "Nächste Fundstelle zeigen"]
            set t(bh_entry)   [ec8 "Eingabefeld für den regulären Ausdruck"]
            set t(bh_check)   [ec8 "Anwenden des regulären Ausdrucks auf den Text"]
            set t(hinweis)    "Hinweis"
            set t(cannotopenfile) [ec8 "Datei kann nicht geöffnet werden"]
            set t(savetexttofile) "Textinhalt speichern"
            set t(regexpwrong)  [ec8 "regulärer Ausdruck falsch!"]
            set t(nomorematches) "Keine weiteren Fundstellen"
            set t(close)       {Schließen}
        }
    } ;# switch
} ;# proc InitLocalizedText

proc balloonhelp {w msg} {
    bind $w <Enter> "after 1000 \"balloon_aux %W [list $msg]\""
    bind $w <Leave> "after cancel \"balloon_aux %W [list $msg]\"
    after 100 {catch {destroy .balloon_help}}"
} ;# proc balloon_help


proc balloon_aux {w msg} {
    set t .balloon_help
    catch {destroy $t}
    toplevel $t
    wm overrideredirect $t 1
    pack [label $t.l -text $msg -relief groove -bd 1 -bg gold] -fill both
    set x [expr [winfo rootx $w]+6+[winfo width $w]/2]
    set y [expr [winfo rooty $w]+6+[winfo height $w]/2]
    wm geometry $t +$x\+$y
    bind $t <Enter> {after cancel {catch {destroy .balloon_help}}}
    bind $t <Leave> "catch {destroy .balloon_help}"
} ;# proc balloon_aux



proc Init {} {
    global g
    InitLocalizedText
    set g(dir) [file dirname [info script]]
    set g(fn) ""
    set g(fundstellen) ""
    set g(gesamtAnzahl) 0
    
    Bildschirm
} ;# proc Init


################# HAUPTPROGRAMM #####################
Init

# END OF SOURCE



