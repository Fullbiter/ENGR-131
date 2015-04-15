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
btn_A = uicontrol('style','pushbutton','position',[10 40 25 25],'string','A',...
                  'fontsize',12,'callback',@chooseLetter);
btn_B = uicontrol('style','pushbutton','position',[40 40 25 25],'string','B',...
                  'fontsize',12,'callback',@chooseLetter);
btn_C = uicontrol('style','pushbutton','position',[70 40 25 25],'string','C',...
                  'fontsize',12,'callback',@chooseLetter);
btn_D = uicontrol('style','pushbutton','position',[100 40 25 25],'string','D',...
                  'fontsize',12,'callback',@chooseLetter);
btn_E = uicontrol('style','pushbutton','position',[130 40 25 25],'string','E',...
                  'fontsize',12,'callback',@chooseLetter);
btn_F = uicontrol('style','pushbutton','position',[160 40 25 25],'string','F',...
                  'fontsize',12,'callback',@chooseLetter);
btn_G = uicontrol('style','pushbutton','position',[190 40 25 25],'string','G',...
                  'fontsize',12,'callback',@chooseLetter);
btn_H = uicontrol('style','pushbutton','position',[220 40 25 25],'string','H',...
                  'fontsize',12,'callback',@chooseLetter);
btn_I = uicontrol('style','pushbutton','position',[250 40 25 25],'string','I',...
                  'fontsize',12,'callback',@chooseLetter);
btn_J = uicontrol('style','pushbutton','position',[280 40 25 25],'string','J',...
                  'fontsize',12,'callback',@chooseLetter);
btn_K = uicontrol('style','pushbutton','position',[310 40 25 25],'string','K',...
                  'fontsize',12,'callback',@chooseLetter);
btn_L = uicontrol('style','pushbutton','position',[340 40 25 25],'string','L',...
                  'fontsize',12,'callback',@chooseLetter);
btn_M = uicontrol('style','pushbutton','position',[370 40 25 25],'string','M',...
                  'fontsize',12,'callback',@chooseLetter);
btn_N = uicontrol('style','pushbutton','position',[10 10 25 25],'string','N',...
                  'fontsize',12,'callback',@chooseLetter);
btn_O = uicontrol('style','pushbutton','position',[40 10 25 25],'string','O',...
                  'fontsize',12,'callback',@chooseLetter);
btn_P = uicontrol('style','pushbutton','position',[70 10 25 25],'string','P',...
                  'fontsize',12,'callback',@chooseLetter);
btn_Q = uicontrol('style','pushbutton','position',[100 10 25 25],'string','Q',...
                  'fontsize',12,'callback',@chooseLetter);
btn_R = uicontrol('style','pushbutton','position',[130 10 25 25],'string','R',...
                  'fontsize',12,'callback',@chooseLetter);
btn_S = uicontrol('style','pushbutton','position',[160 10 25 25],'string','S',...
                  'fontsize',12,'callback',@chooseLetter);
btn_T = uicontrol('style','pushbutton','position',[190 10 25 25],'string','T',...
                  'fontsize',12,'callback',@chooseLetter);
btn_U = uicontrol('style','pushbutton','position',[220 10 25 25],'string','U',...
                  'fontsize',12,'callback',@chooseLetter);
btn_V = uicontrol('style','pushbutton','position',[250 10 25 25],'string','V',...
                  'fontsize',12,'callback',@chooseLetter);
btn_W = uicontrol('style','pushbutton','position',[280 10 25 25],'string','W',...
                  'fontsize',12,'callback',@chooseLetter);
btn_X = uicontrol('style','pushbutton','position',[310 10 25 25],'string','X',...
                  'fontsize',12,'callback',@chooseLetter);
btn_Y = uicontrol('style','pushbutton','position',[340 10 25 25],'string','Y',...
                  'fontsize',12,'callback',@chooseLetter);
btn_Z = uicontrol('style','pushbutton','position',[370 10 25 25],'string','Z',...
                  'fontsize',12,'callback',@chooseLetter);

% Open the dictionary and save the words
fid = fopen('dictionary.txt');
dictionary = textscan(fid,'%s');
fclose(fid);

% Pick a random word from the dictionary
secretWord = dictionary{1}{randi(length(dictionary{1}))}
% Create a text element to show correctly guessed letters
shownWord = uicontrol('style','text','position',[10 80 380 40],'string','_ _ _ _ _',...
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

% Counters for each type of guess
badGuessCount = 0;
goodGuessCount = 0;
    
    function chooseLetter(source,eventdata)
        % Store the shown word
        text = get(shownWord,'string');
        % Store the guessed letter
        letter = get(source,'string');
        % Find and store the indexes that match the letter
        matchedIndexes = strfind(secretWord, letter)
        if length(matchedIndexes) == 0
            badGuessCount = badGuessCount + 1
        else
            matchedIndexes = matchedIndexes * 2 - 1;
            text(matchedIndexes) = letter
            set(shownWord,'string',text);
            goodGuessCount = goodGuessCount + 1
        end
        % Disable the letter button
        set(source,'enable','off');
    end
end