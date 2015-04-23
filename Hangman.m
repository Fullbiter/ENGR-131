% Authors: Kevin Nash
% Date: 4/17/2015

% The game's main function
function [] = Hangman()

% Create the window
width = 400; height = 300;
window = figure('visible','on',...
                'units','pixels',...
                'position',[0 0 width height],...
                'menubar','none',...
                'numbertitle','off',...
                'name','HANGMAN',...
                'resize','off');
movegui(window, 'center');

% Create play button
btn_play = uicontrol('style','pushbutton','position',[145 80 110 40],'string','Play',...
                     'fontsize',18,'callback',@play);
% Create stats button
btn_scores = uicontrol('style','pushbutton','position',[145 45 110 30],'string','High Scores',...
                     'fontsize',12,'callback',@score);

% Create all letter buttons
btns_letter = zeros(1,26);
btns_letter(1) = uicontrol('visible','off','style','pushbutton','position',[10 40 25 25],'string','A',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(2) = uicontrol('visible','off','style','pushbutton','position',[40 40 25 25],'string','B',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(3) = uicontrol('visible','off','style','pushbutton','position',[70 40 25 25],'string','C',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(4) = uicontrol('visible','off','style','pushbutton','position',[100 40 25 25],'string','D',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(5) = uicontrol('visible','off','style','pushbutton','position',[130 40 25 25],'string','E',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(6) = uicontrol('visible','off','style','pushbutton','position',[160 40 25 25],'string','F',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(7) = uicontrol('visible','off','style','pushbutton','position',[190 40 25 25],'string','G',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(8) = uicontrol('visible','off','style','pushbutton','position',[220 40 25 25],'string','H',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(9) = uicontrol('visible','off','style','pushbutton','position',[250 40 25 25],'string','I',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(10) = uicontrol('visible','off','style','pushbutton','position',[280 40 25 25],'string','J',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(11) = uicontrol('visible','off','style','pushbutton','position',[310 40 25 25],'string','K',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(12) = uicontrol('visible','off','style','pushbutton','position',[340 40 25 25],'string','L',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(13) = uicontrol('visible','off','style','pushbutton','position',[370 40 25 25],'string','M',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(14) = uicontrol('visible','off','style','pushbutton','position',[10 10 25 25],'string','N',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(15) = uicontrol('visible','off','style','pushbutton','position',[40 10 25 25],'string','O',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(16) = uicontrol('visible','off','style','pushbutton','position',[70 10 25 25],'string','P',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(17) = uicontrol('visible','off','style','pushbutton','position',[100 10 25 25],'string','Q',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(18) = uicontrol('visible','off','style','pushbutton','position',[130 10 25 25],'string','R',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(19) = uicontrol('visible','off','style','pushbutton','position',[160 10 25 25],'string','S',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(20) = uicontrol('visible','off','style','pushbutton','position',[190 10 25 25],'string','T',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(21) = uicontrol('visible','off','style','pushbutton','position',[220 10 25 25],'string','U',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(22) = uicontrol('visible','off','style','pushbutton','position',[250 10 25 25],'string','V',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(23) = uicontrol('visible','off','style','pushbutton','position',[280 10 25 25],'string','W',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(24) = uicontrol('visible','off','style','pushbutton','position',[310 10 25 25],'string','X',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(25) = uicontrol('visible','off','style','pushbutton','position',[340 10 25 25],'string','Y',...
                  'fontsize',12,'callback',@chooseLetter);
btns_letter(26) = uicontrol('visible','off','style','pushbutton','position',[370 10 25 25],'string','Z',...
                  'fontsize',12,'callback',@chooseLetter);

% Open the dictionary and save the words
fid = fopen('dictionary.txt');
dictionary = textscan(fid,'%s');
fclose(fid);

% Open the stats file and save the scores
fid = fopen('stats.txt');
scores = textscan(fid,'%s');
fclose(fid);

% Create a text element to display the title
txt_title = uicontrol('visible','on','style','text','position',[10 180 380 70],...
                      'string','Hangman','fontsize',42);
% Create a text element to display the author names
txt_devs = uicontrol('visible','on','style','text','position',[10 150 380 30],...
                      'string','Created by Kevin Nash','fontsize',10);
% Pick a random word from the dictionary
txt_secret = dictionary{1}{randi(length(dictionary{1}))};
% Create a text element to show correctly guessed letters
txt_shown = uicontrol('visible','off','style','text','position',[10 80 380 40],'string','_ _ _ _ _',...
                      'fontsize',26);
% Create the game over text
txt_end = uicontrol('visible','off','style','text','position',[10 240 380 60],...
                    'string','null','fontsize',42);
                
% Create the high scores text
txt_score1 = uicontrol('visible','off','style','text','position',[10 175 380 40],'string',...
                       [scores{1}{1},'    ',scores{1}{2}],'fontsize',26);
txt_score2 = uicontrol('visible','off','style','text','position',[10 135 380 40],'string',...
                       [scores{1}{3},'    ',scores{1}{4}],'fontsize',26);
txt_score3 = uicontrol('visible','off','style','text','position',[10 95 380 40],'string',...
                       [scores{1}{5},'    ',scores{1}{6}],'fontsize',26);


% Counter for incorrect guesses
badGuessCount = 0;
% Counter for the number of remaining letters
usedLetterCount = length(unique(txt_secret));
lettersRemaining = usedLetterCount;

% Callback function for the play button
function play(source,eventdata)
    set(btn_play,'enable','off','visible','off');
    set(btn_scores,'enable','off','visible','off');
    set(txt_title,'visible','off');
    set(txt_devs,'visible','off');
    set(txt_shown,'visible','on');
    for i = 1:length(btns_letter)
        set(btns_letter(i),'visible','on');
    end
end

% Callback function for the statistics button
function score(source,eventdata)
    set(btn_play,'enable','off','visible','off');
    set(btn_scores,'enable','off','visible','off');
    set(txt_title,'visible','off');
    set(txt_devs,'visible','off');
    set(txt_score1,'visible','on');
    set(txt_score2,'visible','on');
    set(txt_score3,'visible','on');
end

% Callback function for the letter buttons
function chooseLetter(source,eventdata)
    % Store the shown word
    text = get(txt_shown,'string');
    % Store the guessed letter
    letter = get(source,'string');
    % Find and store the indexes that match the letter
    matchedIndexes = strfind(txt_secret, letter);
    % Guess is correct
    if length(matchedIndexes) == 0
        badGuessCount = badGuessCount + 1;
        if badGuessCount >= 5
            endGame(0);
        end
    % Guess is incorrect
    else
        matchedIndexes = matchedIndexes * 2 - 1;
        text(matchedIndexes) = letter;
        set(txt_shown,'string',text);
        lettersRemaining = lettersRemaining - 1;
        if lettersRemaining <= 0
            endGame(1);
        end
    end
    % Disable the letter button
    set(source,'enable','off');
end
    
% Function that ends the game with a win or loss
function endGame(result)
    % Disable all letter buttons
    for i = 1:length(btns_letter)
        set(btns_letter(i),'enable','off');
    end
    % Reveal the secret word
    txt_final = get(txt_shown,'string');
    for i = 1:length(txt_secret)
        txt_final(i * 2 - 1) = txt_secret(i);
    end
    set(txt_shown,'string',txt_final);
    % Game is lost
    if result == 0
        set(txt_end,'string','GAME OVER');
    end
    % Game is won
    if result == 1
        set(txt_end,'string','WINNER');
    end
    % Show the end game message
    set(txt_end,'visible','on');
end
end