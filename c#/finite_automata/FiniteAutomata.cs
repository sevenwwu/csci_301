using System;
using System.Collections.Generic;
using System.Collections.Immutable;



public class FiniteAutomaton<T>
{
    public readonly ImmutableHashSet<T> States;
    public readonly ImmutableHashSet<char> Alphabet;
    public readonly ImmutableDictionary<(T, char), T> TransitionFunction;
    public readonly T StartState;
    public readonly ImmutableHashSet<T> AcceptStates;

    public FiniteAutomaton(HashSet<T> states, HashSet<char> alphabet, Dictionary<(T, char), T> transitionFunction,
                            T startState, HashSet<T> acceptStates)
    {
        States = states.ToImmutableHashSet();
        Alphabet = alphabet.ToImmutableHashSet();
        TransitionFunction = transitionFunction.ToImmutableDictionary();
        StartState = startState;
        AcceptStates = acceptStates.ToImmutableHashSet();

        ValidateStartState();
        ValidateAcceptStates();
        ValidateTransitionFunction();
    }

    // Nondeterministic Finite Automaton
    public static FiniteAutomaton<HashSet<T>> NonDeterministicFiniteAutomaton
    (HashSet<T> states, HashSet<char> alphabet, Dictionary<(T, char), ImmutableHashSet<T>> transitionFunction,
                            T startState, HashSet<T> acceptStates)
    {
        var States = new HashSet<HashSet<T>>();

        foreach 
    }

    private void ValidateStartState()
    {
        if (!States.Contains(StartState))
        {
            throw new InvalidOperationException($"Start state {StartState} is not in defined states.");
        }
    }

    private void ValidateAcceptStates()
    {
        foreach (var curState in AcceptStates)
        {
            if (!States.Contains(curState))
            {
                throw new InvalidOperationException($"Accept state {curState} is not in defined states.");
            }
        }
    }

    private void ValidateTransitionFunction()
    {
        foreach (var state in States)
        {
            foreach (var symbol in Alphabet)
            {
                if (!TransitionFunction.ContainsKey((state, symbol)))
                {
                    throw new InvalidOperationException($"Transition function is not defined for state {state} and symbol '{symbol}'.");
                }
            }
        }
    }

    public bool Accepts(string input)
    {
        T currentState = StartState;

        foreach (char symbol in input)
        {
            if (!Alphabet.Contains(symbol))
            {
                throw new ArgumentException($"Symbol '{symbol}' is not in the language alphabet.");
            }

            currentState = TransitionFunction[(currentState, symbol)];
        }

        return AcceptStates.Contains(currentState);
    }


    public static FiniteAutomaton<(T1,T2)> Union<T1,T2>(FiniteAutomaton<T1> m1, FiniteAutomaton<T2> m2)
    {
        var states = new HashSet<(T1, T2)>();

        foreach (var stateM1 in m1.States)
        {
            foreach (var stateM2 in m2.States)
            {
                states.Add((stateM1,stateM2));
            }
        }


        if (!m1.Alphabet.SetEquals(m2.Alphabet))
        {
            throw new InvalidOperationException($"Alphabets do not match.");
        }

        var alphabet = new HashSet<char>(m1.Alphabet);


        var transitionFunction = new Dictionary<((T1,T2),char),(T1,T2)>();
        foreach (var stateM1 in m1.States)
        {
            foreach (var stateM2 in m2.States)
            {
                foreach (var chr in alphabet)
                {
                    transitionFunction.Add(((stateM1,stateM2),chr),(m1.TransitionFunction[(stateM1,chr)],m2.TransitionFunction[(stateM2,chr)]));
                }
            }
        }

        var startState = (m1.StartState,m2.StartState);

        var acceptStates = new HashSet<(T1,T2)>();
        foreach (var accStateM1 in m1.AcceptStates)
        {
            foreach (var stateM2 in m2.States)
            {
                acceptStates.Add((accStateM1,stateM2));
            }
        } 
        foreach (var stateM1 in m1.States)
        {
            foreach (var accStateM2 in m2.AcceptStates)
            {
                acceptStates.Add((stateM1,accStateM2));
            }
        } 

        return new FiniteAutomaton<(T1,T2)>(states,alphabet,transitionFunction,startState,acceptStates);
    }
}