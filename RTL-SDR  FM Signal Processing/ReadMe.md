# RLT-SDR Device: FM SIGNAL CAPTURING AND PROCESSING 

## Description:
        We'll capture a FM Signal using a RTL SDR device that we will filter and 
    process using some python libraries, such as: matplotlib, scipy, sounddevice,
    numpy:

        1. Capture the FM Signal from the setted frequency;
        2. Create a low-pass filter using scipy.signal.firwin;
        3. Filter the captured signal;
        4. Subsampling the captured signal;
        5. Demodulate the captured signal;
        6. Calculate the FFT of the demodulated signal;
        7. Extraction of the audio signal(mono) by filtering and subsampling;
        8. Playing the signal and saving it as wav


## Requirements:

    1. Python3 and pip for Python3 
    2. Install librtlsdr (for to use RTL-SDR device)
        - On MAC OS:
            sudo port install rtl-sdr
            or 
            brew: https://macappstore.org/librtlsdr/

        - On Linux:
            sudo apt-get install  librtlsdr-dev

    3. Install matplotlib, scipy, sounddevice for Python3:
        pip3 install pyrtlsdr matplotlib scipy sounddevice

## How to run:
    
    1. Connect RTL-SDR device to your laptop/PC;
    2. Run in your terminal: python3 lab_rtl_sdr.py