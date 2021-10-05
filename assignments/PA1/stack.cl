(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *  Skeleton file
 *)

class Main inherits IO {
  m_head : StackCommand;

   main() : Object {
     {
       let input : String,
          pred : Bool <- true in
            while pred loop {
                input <- in_string();
                if input = "d" then displayStack() else
                if input = "x" then {pred <- false; 0; } else
                if input = "e" then m_head <- m_head.eval() else
                m_head <- commandFromString(input) fi fi fi;
            }
            pool;
      }
   };

   commandFromString(input : String) : StackCommand {
       if input = "s" then (new SwapCommand).init(m_head, input) else
       if input = "+" then (new PlusCommand).init(m_head, input) else
       (new IntCommand).initIntCommand(m_head, input)
       fi fi
   };

   displayStack() : Object {
     {
       let temp_head : StackCommand <- m_head in
         while (not isvoid temp_head) loop {
           out_string(temp_head.commandString());
           out_string(" ");
           temp_head <- temp_head.next();
         } pool;
         out_string("\n");
     }
   };

};

class StackCommand {
  m_next : StackCommand;
  m_value : String;

  init(next : StackCommand, value : String) : StackCommand {
    {
      m_next <- next;
      m_value <- value;
      self;
    }
  };

  isInt() : Bool {
    false
  };

  getInt() : Int {
    (new A2I).a2i(m_value)
  };

  hasNext() : Bool {
    not isvoid m_next
  };

  next() : StackCommand {
    m_next
  };

  setNext(next : StackCommand) : StackCommand {
    {
      m_next <- next;
      self;
    }
  };

  commandString() : String {
    m_value
  };

  eval() : StackCommand {
    self
  };
};

class IntCommand inherits StackCommand {
  initIntCommand(next : StackCommand, value : String) : StackCommand {
    init(next, value)
  };

  isInt() : Bool { true };

};

class SwapCommand inherits StackCommand {
  initSwapCommand(next : StackCommand, value : String) : StackCommand {
    init(next, value)
  };

  eval() : StackCommand {
    {
      let first : StackCommand <- next(),
      second : StackCommand <- first.next(),
      third : StackCommand <- second.next() in {
        first.setNext(third);
        second.setNext(first);
        second;
      };
    }
  };
};

class PlusCommand inherits StackCommand {
  initPlusCommand(next : StackCommand, value : String) : StackCommand {
    init(next, value)
  };

  eval() : StackCommand {
      let first : StackCommand <- next(),
      second : StackCommand <- first.next(),
      third : StackCommand <- second.next(),
      sum : Int <- first.getInt() + second.getInt(),
      stringSum : String <- (new A2I).i2a(sum) in
        (new IntCommand).initIntCommand(third, stringSum)
  };

};
