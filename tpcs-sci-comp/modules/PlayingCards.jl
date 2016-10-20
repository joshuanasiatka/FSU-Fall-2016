module PlayingCards

export Card,print_card,card_rank,card_suit,Hand,print_hand,isAFullHouse,isAFlush,isAStraight,isATwoPair,isARoyalFlush,isAStraightFlush,getProbability

### First let's get the basics out of the way
ranks = ['A','2','3','4','5','6','7','8','9','T','J','Q','K']
suits = ['\u2660','\u2661','\u2662','\u2663']

## Create the type Card
type Card
    rank::Int
    suit::Int

    # construct a card based on the rank and suit
    Card(r::Int,s::Int)=r<1||r>13?throw(ArgumentError("The rank must be an integer between 1 and 13.")):s<1||s>4?throw(ArgumentError("The suit must be an integer between 1 and 4.")):new(r,s)

    # construct a card based on the number in a deck
    Card(i::Int) = i<1||i>52?throw(ArgumentError("The argument must be an integer between 1 and 52")):i%13==0? new(13,Int(ceil(i/13))) : new(i%13,Int(ceil(i/13)))

    # construct a card based on a string representation of the card
    function Card(str::String)
        if length(str)>2
            throw(ArgumentError("The string should only be 2 characters"))
        end
        local r = findfirst(a->a==str[1],ranks)
        if r<1 || r>13
            throw(ArgumentError(string("The first character should be one of ",join(ranks,","))))
        end
        local s=findfirst(a->a==str[2],suits)
        if s<1 || s>4
            throw(ArgumentError(string("The second character should be one of ",join(suits,","))))
        end
        new(r,s)
    end
end

## Return Card in form of string e.g. 7H
function print_card(c::Card)
    string(ranks[c.rank],suits[c.suit]);
end

## Return rank from Card
function card_rank(c::Card)
    return c.rank
end

## Return suit from Card
function card_suit(c::Card)
    return c.suit
end

## Create another type Hand which holds an array of Cards
type Hand
    cards::Array{Card,1}
    Hand(c::Array{Card,1})=new(c)
    Hand(c::Array{String,1})=new(map(Card,c))
    Hand(s::String)=new(map(Card,map(String,split(s,','))))
end

## Print the Hand
function print_hand(h::Hand)
    join(map(print_card,h.cards),",")
end

### Probability Functions
function isAFullHouse(h::Hand)
    # return true if the hand is a full house and false otherwise
    card_ranks=sort(map(card_rank,h.cards))
    return card_ranks[1]==card_ranks[2] && card_ranks[4]==card_ranks[5] && (card_ranks[2]==card_ranks[3] || card_ranks[3]==card_ranks[4]) && card_ranks[2]!=card_ranks[4]
end

function isAFlush(h::Hand)
    card_suits=sort(map(card_suit,h.cards))
    return card_suits[1]==card_suits[2] && card_suits[2]==card_suits[3] &&
    card_suits[3]==card_suits[4] && card_suits[4]==card_suits[5]
end

function isAStraight(h::Hand)
    card_ranks=sort(map(card_rank,h.cards))
    return card_ranks[5]==card_ranks[4]+1 && card_ranks[4]==card_ranks[3]+1 &&
    card_ranks[3]==card_ranks[2]+1 && card_ranks[2]==card_ranks[1]+1
end

function isAStraightFlush(h::Hand)
    cr=sort(map(card_rank,h.cards))
    cs=map(card_suit,h.cards)
    if (cs[1]==cs[2] && cs[1]==cs[3] && cs[1]==cs[4] && cs[1]==cs[5])
        return (cr[1]==cr[2]-1 && cr[2]==cr[3]-1 && cr[3]==cr[4]-1 &&
        cr[4]==cr[5]-1)
    else
        return false
    end
end

function isARoyalFlush(h::Hand)
    cr=sort(map(card_rank,h.cards))
    cs=map(card_suit,h.cards)
    if (cs[1]==cs[2] && cs[1]==cs[3] && cs[1]==cs[4] && cs[1]==cs[5])
        return (cr[1]==1 && cr[2]==10 && cr[3]==11 &&
        cr[4]==12 && cr[5]==13)
    else
        return false
    end
end

function isATwoPair(h::Hand)
    cr=sort(map(card_rank,h.cards))
    return ((cr[1]==cr[2] && cr[3]==cr[4] && (cr[1]!=cr[5] && cr[3]!=cr[5]))
    || ((cr[1]!=cr[2] && cr[1]!=cr[4]) && cr[2]==cr[3] && cr[4]==cr[5])
    || (cr[1]==cr[2] && (cr[3]!=cr[1] && cr[3]!=cr[4]) && cr[4]==cr[5]))
end

## Probability Checker
function getProbability(f::Function)
    deck=collect(1:52);
    numhands=0;
    trials = 1000000
    for i=1:trials
        shuffle!(deck)
        h = Hand(map(Card,deck[1:5]))
        if(f(h))
            numhands+=1
        end
    end
    return numhands/trials
end

end
