//
//  Card.m
//  Matchismo
//
//  Created by Mario Grimaldi on 02/05/14.
//  Copyright (c) 2014 Mario. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if([self.contents isEqualToString:card.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
