import os
import sys
sys.path.insert(0, './cyUSB')# Import local package: (pywinusb 0.2.9)
import cyUSB as hid
from Crypto.Cipher import AES
from Crypto import Random

tasks = [0]  
 
class EEG(object):
    
    def __init__(self):
        self.hid = None
        self.Delimiter = ", "
        devicesUsed = 0
   
        for device in hid.find_all_hid_devices():
                if device.product_name == 'EEG Signals':
                    devicesUsed += 1
                    self.hid = device
                    self.hid.open()
                    self.serial_number = device.serial_number
                    device.set_raw_data_handler(self.dataHandler)                   
        if devicesUsed == 0:
            os._exit(0)
        sn = self.serial_number
        k = ['\0'] * 16
        k = [sn[-1],sn[-2],sn[-2],sn[-3],sn[-3],sn[-3],sn[-2],sn[-4],sn[-1],sn[-4],sn[-2],sn[-2],sn[-4],sn[-4],sn[-2],sn[-1]]
        self.key = str(''.join(k))
  

    def dataHandler(self, data):
        tasks[0] = (''.join(map(chr, data[1:])))

    def convertEPOC_PLUS(self, value_1, value_2):
        edk_value = "%.8f" % (((int(value_1) * .128205128205129) + 4201.02564096001) + ((int(value_2) -128) * 32.82051289))
        return edk_value
       
    def get_data(self):
        cipher = AES.new(self.key.encode("utf8"), AES.MODE_ECB)
        n = 1
        while(len(tasks) == 0):
            n = 3#dummy instr
                
        task = tasks[0].encode("latin-1") # 1 carater to 1 byte
        try:
            data = cipher.decrypt(task[:16]) + cipher.decrypt(task[16:])
            packet_data = str((data[0])) + self.Delimiter + str((data[1])) + self.Delimiter            
            for i in range(2,16,2):
                packet_data = packet_data + str(self.convertEPOC_PLUS(str((data[i])), str((data[i+1])))) + self.Delimiter                          
            for i in range(18,len(data),2):
                packet_data = packet_data + str(self.convertEPOC_PLUS(str((data[i])), str((data[i+1])))) + self.Delimiter                
            packet_data = packet_data  + str((data[16])) + str(self.Delimiter) + str((data[17])) 
            return [float(i) for i in packet_data.split(self.Delimiter)] 
        except Exception as exception2:
            print(str(exception2))
        
cyHeadset = EEG()