from ffmpy import FFmpeg

f = FFmpeg(inputs={'/home/tushargoel/Desktop/AUD-20200418-WA0006.mp3':None},
			outputs={'/home/tushargoel/Desktop/AUD-20200418-WA0006.wav':'-ac 1 -ar 16000'})

print(f.run())