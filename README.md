### Motivation
: 

### Problem
: * Face-Detection with mood and individual 
* Recommend music to user

## Face Mood 
> * afraid 
>* angry 
>* disgusted 
>* happy 
>* neural 
>* sad 
>* surprised

## Music Label 
> * Blue
> * Classical
> * Country
> * Disco
> * Hiphop
> * Jazz
> * Metal
> * Pop
> * Reggae
> * Rock

### Solution
: #####Part1 Train Mood
>Use HOG and Gabor for feature extraction
>SVM to train model

: #####Part2 Label music 
>Classification of music type
>Use lab tool to classify

: #####Part3: Combine 1,2
>Real-time system to play music

### Result
: #####Part1    
>HOG accuracy up-to 85-90%
>Gabor accuracy is much lower

: #####Part2
>Get 100 songs for labeling 
>Each match the face-mood label

: #####Part3
>Use webcam to detect current face-img to play music

### Ref
: #####Dataset
>faceDetection KDEF
>musicGenre Lab + Youtube





