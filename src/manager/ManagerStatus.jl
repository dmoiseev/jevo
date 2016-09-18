#
# Shows real time status of current Manager
#
# @author DeadbraiN
#
import CodeConfig
import ManagerTypes
#
# Shows real time status obtained from ManagerStatus type
# @param man Manager data type object
# @param stamp Current time stamp
#
function _updateStatus(man::ManagerTypes.ManagerData, stamp::Float64)
  local st::ManagerTypes.ManagerStatus = man.status

  if stamp - st.stamp >= CodeConfig.showStatusPeriod
    println(
      "ips: ",      st.ips,
      ", yield: ",  st.yield,
      ", syield: ", st.stepYield,
      ", rps: ",    st.rps,
      ", srps: ",   st.stepRps,
      ", orgs: ",   length(man.tasks)
    )
    st.stamp     = stamp
    st.ips       = 0
    st.yield     = 0
    st.stepYield = 0
    st.rps       = 0
    st.stepRps   = 0
  end
end
