#include <FastLED.h>
#define LED_PIN     7
#define NUM_LEDS    59

CRGB leds[NUM_LEDS];


void setup()
{
	FastLED.addLeds<WS2812, LED_PIN, GRB>(leds, NUM_LEDS);
}

void RotateStep()
{
		CRGB Temp = leds[NUM_LEDS-1];
		for(int i=NUM_LEDS-1; i>0; i--)
		{
			leds[i]=leds[i-1];
		}
		leds[0] = Temp;
}
void ClearLeds()
{
	for(int I=0;I<NUM_LEDS;I++)
	{
		leds[I]=CRGB(0,0,0);
	} 
}
void LedDisolve(float Amount )
{
	for(int I=0; I< NUM_LEDS; I++)
	{
		leds[I].subtractFromRGB(Amount);
	}
}

void loop() 
{
	
	float Divider = 255 / NUM_LEDS;
	float Value = 0;
	
	//colour lights red
	for(int i =0; i < NUM_LEDS; i++)
	{
		Value = Divider * i;
		leds[i] = CRGB ( Value, 0, 0);
		FastLED.show();
		delay(50);
	}
	//add green to light colour
	for(int i =0; i < NUM_LEDS; i++)
	{
		leds[0] += CRGB(0,255,0);
		RotateStep();
		FastLED.show();
		delay(50);
	}
	//rotate lights around 10 times
	for(int c=0; c < 10; c++)
	{
		for(int i =0; i < NUM_LEDS; i++)
		{
			LedDisolve(0.1);
			RotateStep();
			FastLED.show();
			delay(25);
		}
	}
	//fade to black
	for(int i =0; i < 255; i++)
	{
		LedDisolve(5);
		FastLED.show();
		delay(10);
	}
	//clear all LED's to black
	ClearLeds();
}
