% Authors: Kevin Nash
% Date: 4/14/2015

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

% Create all letter buttons
buttons = zeros(1,26);
buttons(1) = uicontrol('style','pushbutton','position',[10 40 25 25],'string','A',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(2) = uicontrol('style','pushbutton','position',[40 40 25 25],'string','B',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(3) = uicontrol('style','pushbutton','position',[70 40 25 25],'string','C',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(4) = uicontrol('style','pushbutton','position',[100 40 25 25],'string','D',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(5) = uicontrol('style','pushbutton','position',[130 40 25 25],'string','E',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(6) = uicontrol('style','pushbutton','position',[160 40 25 25],'string','F',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(7) = uicontrol('style','pushbutton','position',[190 40 25 25],'string','G',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(8) = uicontrol('style','pushbutton','position',[220 40 25 25],'string','H',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(9) = uicontrol('style','pushbutton','position',[250 40 25 25],'string','I',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(10) = uicontrol('style','pushbutton','position',[280 40 25 25],'string','J',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(11) = uicontrol('style','pushbutton','position',[310 40 25 25],'string','K',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(12) = uicontrol('style','pushbutton','position',[340 40 25 25],'string','L',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(13) = uicontrol('style','pushbutton','position',[370 40 25 25],'string','M',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(14) = uicontrol('style','pushbutton','position',[10 10 25 25],'string','N',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(15) = uicontrol('style','pushbutton','position',[40 10 25 25],'string','O',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(16) = uicontrol('style','pushbutton','position',[70 10 25 25],'string','P',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(17) = uicontrol('style','pushbutton','position',[100 10 25 25],'string','Q',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(18) = uicontrol('style','pushbutton','position',[130 10 25 25],'string','R',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(19) = uicontrol('style','pushbutton','position',[160 10 25 25],'string','S',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(20) = uicontrol('style','pushbutton','position',[190 10 25 25],'string','T',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(21) = uicontrol('style','pushbutton','position',[220 10 25 25],'string','U',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(22) = uicontrol('style','pushbutton','position',[250 10 25 25],'string','V',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(23) = uicontrol('style','pushbutton','position',[280 10 25 25],'string','W',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(24) = uicontrol('style','pushbutton','position',[310 10 25 25],'string','X',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(25) = uicontrol('style','pushbutton','position',[340 10 25 25],'string','Y',...
                  'fontsize',12,'callback',@chooseLetter);
buttons(26) = uicontrol('style','pushbutton','position',[370 10 25 25],'string','Z',...
                  'fontsize',12,'callback',@chooseLetter);

% Create, then hide, the game over text
txt_end = uicontrol('visible','off','style','text','position',[10, 240, 380, 60],...
                    'string','null','fontsize',42);

% Open the dictionary and save the words
fid = fopen('dictionary.txt');
dictionary = textscan(fid,'%s');
fclose(fid);

% Pick a random word from the dictionary
txt_secret = dictionary{1}{randi(length(dictionary{1}))};
% Create a text element to show correctly guessed letters
txt_shown = uicontrol('style','text','position',[10 80 380 40],'string','_ _ _ _ _',...
                      'fontsize',26);

% Load the bad guess images
%man_0 = imread('man_0.png');
%man_1 = imread('man_0.png');
%man_2 = imread('man_0.png');
%man_3 = imread('man_0.png');
%man_4 = imread('man_0.png');
%man_5 = imread('man_0.png');

% Status image
%axis equal;
%imshow('man_0.png');

% Counter for incorrect guesses
badGuessCount = 0;
% Counter for the number of remaining letters
usedLetterCount = length(unique(txt_secret));
lettersRemaining = usedLetterCount;

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
        for i = 1:length(buttons)
            set(buttons(i),'enable','off');
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