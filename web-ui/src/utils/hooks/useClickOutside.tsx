import { useEffect, MutableRefObject } from "react";

const useClickOutside = (ref: MutableRefObject<any>, callback: () => void = () => {}) => {
  useEffect(() => {
    const handleClickOutside = (e: any) => {
      if (ref.current && !ref.current.contains(e.target)) {
        callback;
      }
    };
    document.addEventListener("mousedown", handleClickOutside);

    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [ref]);

  return [callback];
};

export default useClickOutside;
